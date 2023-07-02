class DatetimeSlotSerializer
  include JSONAPI::Serializer

  attributes :id,
             :doctor_id,
             :slot_datetime,
             :is_free

  attribute :doctor do |datetime_slot|
    {
      id: datetime_slot.doctor_id,
      text: datetime_slot.doctor&.full_name,
    }
  end
end