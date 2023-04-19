class AppointmentSerializer
  include JSONAPI::Serializer

  attributes :id,
             :appointment_datetime,
             :description,
             :before_visit

  attribute :specialty do |appointment|
    {
      id: appointment.specialty_id,
      text: appointment.specialty&.name,
    }
  end

  attribute :patient do |appointment|
    {
      id: appointment.patient_id,
      text: appointment.patient&.full_name,
    }
  end

  attribute :doctor do |appointment|
    {
      id: appointment.doctor_id,
      text: appointment.doctor&.full_name,
    }
  end

  attribute :cabinet do |appointment|
    {
      id: appointment.cabinet_id,
      text: appointment.cabinet&.name,
    }
  end
end