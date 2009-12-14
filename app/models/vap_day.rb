class VapDay < ActiveRecord::Base
  has_many :vap_request_days
  has_many :vap_requests, :through => :vap_request_days
  
  validates_presence_of :date
  
  def to_param
    (self.date.nil?) ? self.id : self.date
  end
  
  def to_label
    self.date.strftime("%m/%d/%Y")
  end
  
end