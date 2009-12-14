class AddSuperbowlXlivVapDays < ActiveRecord::Migration
  def self.up
    # FIXME: i have no idea what days are in the superbowl xliv -d
    (Date.parse("2010-01-18")..Date.parse("2010-02-07")).each do |date|
      VapDay.create(:date => date)
    end
  end

  def self.down
  end
end
