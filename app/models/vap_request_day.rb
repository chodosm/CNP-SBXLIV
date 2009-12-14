class VapRequestDay < ActiveRecord::Base
  
  belongs_to :vap_day
  belongs_to :vap_request
  
  def to_label
    self.vap_day.date.strftime("%m/%d/%Y")
  end

end