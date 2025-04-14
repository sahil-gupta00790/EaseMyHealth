package validator

import (
	"database/sql"
	"time"
)

func StringFromNullString(ns sql.NullString) string {
	if ns.Valid {
		return ns.String
	}
	return ""
}
func Float64PtrFromNullFloat64(nf sql.NullFloat64) *float64 {
	if nf.Valid {
		val := nf.Float64
		return &val
	}
	return nil
}
func TimeFromNullTime(nt sql.NullTime) time.Time {
	if nt.Valid {
		return nt.Time
	}
	return time.Time{}
}
