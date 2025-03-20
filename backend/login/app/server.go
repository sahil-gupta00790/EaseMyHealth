package main

import (
	"context"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/sirupsen/logrus"
)

func (app *application) server() error {
	srv := &http.Server{
		Addr:         fmt.Sprintf(":%d", app.config.port),
		Handler:      app.routes(),
		ErrorLog:     log.New(app.logger.Writer(), "", 0),
		IdleTimeout:  time.Minute,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
	}
	shutdown := make(chan error)
	//start a background go routine to listen for os signals
	go func() {
		//create a quit/exit channel which carries os.Signal vlaues
		quit := make(chan os.Signal, 1)
		//listen for the SIGINT and SIGTERM signals
		signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
		//Block until a signal is received
		sig := <-quit
		//log a message to say that the signal has been caught
		app.logger.WithFields(logrus.Fields{
			"signal": sig.String(),
		}).Info("shutting down server")
		//create a ctx with 20 seconds timeout
		ctx, cancel := context.WithTimeout(context.Background(), 20*time.Second)
		defer cancel()
		//call the Shutdown() method on our server, passing in the ctx
		err := srv.Shutdown(ctx)
		if err != nil {
			shutdown <- err
		}

		app.logger.WithFields(logrus.Fields{
			"addr": srv.Addr,
		}).Info("Completing background task")
		app.wg.Wait()
		shutdown <- nil
	}()

	app.logger.WithFields(logrus.Fields{
		"addr": srv.Addr,
		"env":  app.config.env,
	}).Info("Starting Server")

	err := srv.ListenAndServe()
	if !errors.Is(err, http.ErrServerClosed) {
		return err
	}
	err = <-shutdown
	if err != nil {
		return err
	}
	app.logger.WithFields(logrus.Fields{
		"addr": srv.Addr,
		"env":  app.config.env,
	}).Info("Stopped server")
	return nil

}
