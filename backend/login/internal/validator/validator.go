package validator

import (
	"fmt"
	"net/url"
	"regexp"
	"strings"
)

var (
	EmailRX = regexp.MustCompile("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
	PhoneRX = regexp.MustCompile(`^\+?\(?[0-9]{3}\)?\s?-\s?[0-9]{3}\s?-?\s?[0-9]{4}$`)
)

// We create a type that wraps out validation  errors map
type Validator struct {
	Errors map[string]string
}

// New() vcreates a new Validator instance
func New() *Validator {
	return &Validator{
		Errors: make(map[string]string),
	}
}

// Valid() checks the errors map for entries
func (v *Validator) Valid() bool {
	return len(v.Errors) == 0
}

// In() checks if an element can be found in a provideed list of elements
func IN(element string, list ...string) bool {
	for i := range list {
		if element == list[i] {
			return true
		}
	}
	return false
}

// Matches() returns true if a strign value matches a specific regex pattern
func Matches(value string, rx *regexp.Regexp) bool {
	return rx.MatchString(value)
}

// Valid website checks if a stirng value is a valid web url
func ValidWebsite(website string) bool {
	_, err := url.ParseRequestURI(website)
	return err == nil

}

// Adderror() adds an entry error to the Errors map
func (v *Validator) AddError(key, message string) {
	if _, exists := v.Errors[key]; !exists {
		v.Errors[key] = message
	}
}

// Check() performs the validation checks and calls the AddError method in turn if an error entry needs to be added
func (v *Validator) Check(ok bool, key, message string) {
	if !ok {
		v.AddError(key, message)
	}
}

// Unique() entries in modes(no repeating values in slice)
func Unique(values []string) bool {
	uniqueValues := make(map[string]bool)
	for _, value := range values {
		uniqueValues[value] = true
	}
	return len(uniqueValues) == len(values)
}

func (v *Validator) CheckRequiredFields(data map[string]string) {
	for field, value := range data {
		v.Check(value != "", field, fmt.Sprintf("%s is required", strings.ReplaceAll(field, "_", " ")))
	}
}
