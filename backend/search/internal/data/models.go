package data

import "database/sql"

type Models struct {
	Doctors       DoctorModel
	HospitalModel HospitalModel
	MedicineModel MedicineModel
}

func NewModels(db *sql.DB) Models {
	return Models{

		Doctors: DoctorModel{
			DB: db,
		},
		HospitalModel: HospitalModel{
			DB: db,
		},
		MedicineModel: MedicineModel{
			DB: db,
		},
	}
}
