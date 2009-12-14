class AddPassengerInfoToVap < ActiveRecord::Migration
  def self.up
    add_column(:vap_requests, :passenger_name, :string)
    add_column(:vap_requests, :passenger_license, :string, :limit => 32)
    add_column(:vap_requests, :passenger_date_of_birth, :date)
    add_column(:vap_requests, :passenger_license_state, :string, :limit => 2)
  end

  def self.down
    remove_column(:vap_requests, :passenger_name)
    remove_column(:vap_requests, :passenger_license)
    remove_column(:vap_requests, :passenger_date_of_birth)
    remove_column(:vap_requests, :passenger_license_state)
  end
end
