package data

import "database/sql"

type Models struct {
	DoctorAvailabilitySlot DoctorAvailabilitySlotModel
	Doctors                DoctorModel
	AppointmentModel       AppointmentModel
}

func NewModels(db *sql.DB) Models {
	return Models{
		DoctorAvailabilitySlot: DoctorAvailabilitySlotModel{
			DB: db,
		},
		Doctors: DoctorModel{
			DB: db,
		},
		AppointmentModel: AppointmentModel{
			DB: db,
		},
	}
}
