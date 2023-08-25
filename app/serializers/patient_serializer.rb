class PatientSerializer
  include JSONAPI::Serializer

  attributes :id,
             :email,
             :first_name,
             :last_name,
             :telephone,
             :active

  attribute :full_name, &:full_name
end