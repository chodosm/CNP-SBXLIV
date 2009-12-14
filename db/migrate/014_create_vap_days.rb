class CreateVapDays < ActiveRecord::Migration
  def self.up
   create_table :vap_days do |t|
     t.column :date, :date
     t.column :updated_at, :datetime
     t.column :created_at, :datetime
   end
   create_table :vap_request_days do |t|
     t.column :vap_day_id, :integer
     t.column :vap_request_id, :integer
   end
   (Date.parse("2008-01-28")..Date.parse("2008-02-03")).each do |date|
     VapDay.create(:date => date)
   end
  end
  
  def self.down
    drop_table :vap_days
    drop_table :vap_request_days
  end
end