class DoctorSerializer
  include JSONAPI::Serializer

  attributes :id,
             :email,
             :first_name,
             :last_name,
             :telephone,
             :active

  attribute :specialty do |doctor|
    {
      id: doctor.specialty_id,
      name: doctor.specialty&.name,
    }
  end

  attribute :cabinet do |doctor|
    {
      id: doctor.cabinet_id,
      name: doctor.cabinet.name,
    }
  end
end