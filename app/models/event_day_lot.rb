class EventDayLot < ActiveRecord::Base
  set_table_name 'EVENT_MULTI_DAY_LOTS'
  set_primary_key 'dlot_id'

  belongs_to :event_day, :foreign_key => :day_id

  def capacity?
	dlot_capacity > dlot_sold
  end

end
