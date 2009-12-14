class AccessCode < ActiveRecord::Base
  set_table_name 'EVENT_ACCESS_CODES'
  belongs_to :event
  belongs_to :event_lot, :foreign_key => :lot_id
  def lot; event_lot; end
  def day_lots; lot.event_day_lots; end
  def days; day_lots.map{|x|x.event_day}; end
  def day_dates; days.collect{|x|x.day_start.strftime("%a, %b. %d")}; end
  has_one :event_lot


end
