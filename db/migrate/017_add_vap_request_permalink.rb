class AddVapRequestPermalink < ActiveRecord::Migration
  def self.up
    add_column(:vap_requests, :permalink, :string, :null => true)
    add_index(:vap_requests, :permalink)
    VapRequest.find(:all).each do |request|
      request.save_with_validation(perform_validation = false)
    end
  end
  
  def self.down
    remove_column(:vap_requests, :permalink)
  end
end