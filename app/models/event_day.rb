class EventDay < ActiveRecord::Base
  set_table_name 'EVENT_MULTI_DAYS'
  set_primary_key 'day_id'

  belongs_to :event

  has_many :event_day_lots

end
