class EventLot < ActiveRecord::Base
  set_table_name 'EVENT_LOTS'
  set_primary_key 'event_lot_id'
  belongs_to :event
  has_many :event_day_lots, :foreign_key => :event_lot_id

  def access_control
    CnpLookupCode.find(access_control_id).value
  end

  def access_controlled?
    access_control == 'AC_ENABLED'
  end
end
