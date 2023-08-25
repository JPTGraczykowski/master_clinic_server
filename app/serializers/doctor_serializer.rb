class DoctorSerializer
  include JSONAPI::Serializer

  attributes :id,
             :email,
             :first_name,
             :last_name,
             :telephone,
             :active

  attribute :full_name, &:full_name

  attribute :specialty do |doctor|
    {
      id: doctor.specialty_id,
      text: doctor.specialty&.name,
    }
  end

  attribute :cabinet do |doctor|
    {
      id: doctor.cabinet_id,
      text: doctor.cabinet.name,
    }
  end
end