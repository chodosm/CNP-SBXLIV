class AddVapRequestLocation < ActiveRecord::Migration
  def self.up
    add_column(:vap_requests, :delivery_location, :string)
  end
  
  def self.down
    remove_column(:vap_requests, :delivery_location)
  end
end