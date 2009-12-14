class RemoveVapRequestRestrictions < ActiveRecord::Migration
  def self.up
    change_column(:vap_requests, :access_date, :date, :null => true, :default => "0000-00-00")
    change_column(:vap_requests, :event_id, :integer, :null => true, :default => 0)
  end
  
  def self.down
    change_column(:vap_requests, :access_date, :date, :null => false, :default => "0000-00-00")
    change_column(:vap_requests, :event_id, :integer, :null => false, :default => 0)
  end
end