class CabinetSerializer
  include JSONAPI::Serializer

  attributes :id,
             :name,
             :floor
end