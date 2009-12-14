class Event < ActiveRecord::Base
  set_table_name 'EVENTS'
  set_primary_key 'event_id'

  has_many :event_days
  has_many :event_lots
  has_many :access_codes, :foreign_key => "event_id"
  
  def multi_day_status
    CnpLookupCode.find(multi_day_status_id).value
  end

  def multi_day?
    multi_day_status != 'MULTI_DAY_SINGLE_ITEM'
  end

end # class Event

