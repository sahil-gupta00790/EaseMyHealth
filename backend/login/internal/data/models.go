package data

import "database/sql"

type Models struct {
	Users       UserModel
	UserDetails UserDetailsModel
}

func NewModels(db *sql.DB) Models {
	return Models{
		Users: UserModel{
			DB: db,
		},
		UserDetails: UserDetailsModel{
			DB: db,
		},
	}
}
