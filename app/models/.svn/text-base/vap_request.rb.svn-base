require 'rubygems'
require 'ajax_scaffold'
require 'uuidtools'

class VapRequest < ActiveRecord::Base
  belongs_to :vap_vehicle_type
  belongs_to :vap_purpose
  #belongs_to :vap_access

  has_many :vap_request_days
  has_many :vap_days, :through => :vap_request_days, :source => :vap_day
  
  validates_presence_of :vendor, :driver_license, :driver_license_state, :driver_birth_date, :contact_name, :contact_phone, :department, :driver_name, :vehicle_color, :delivery_location
  validates_presence_of :vap_vehicle_type_other,
    :if => Proc.new{|request| request.vap_vehicle_type_id.nil? || request.vap_vehicle_type_id < 1 }
  validates_presence_of :vap_purpose_other,
    :if => Proc.new{|request| request.vap_purpose_id.nil? || request.vap_purpose_id < 1 }
  validates_associated :vap_purpose, 
    :if => Proc.new{|request| request.vap_purpose_other.blank? }
  validates_associated  :vap_vehicle_type,
    :if => Proc.new{|request| request.vap_vehicle_type_other.blank? }
  validates_format_of   :email,
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  # FIXME: figure these out
  # validates_associated  :vap_access  
  # validates_presence_of :vap_access_other
  
  attr_accessor :vap_day_ids
  after_save :update_days
  
  def to_label
    self.id
  end
  
  def delivery_time_output
    t = read_attribute("delivery_time")
    unless t.nil?
      t = t.strftime("%I:%M %p")
    end
    return t
  end
  
  def to_csv
    lines = []
    self.vap_days.each do |vap_day|
      line = []
      line << "\"#{self.id}\""
      line << "\"#{vap_day.date}\""
      line << "\"#{self.delivery_time_output}\""
      line << "\"#{self.vendor}\""
      line << "\"#{self.email}\""
      line << "\"#{self.driver_name}\""
      line << "\"#{self.driver_license}\""
      line << "\"#{self.driver_license_state}\""
      line << "\"#{self.driver_birth_date}\""
      line << "\"#{self.vehicle_type}\""
      line << "\"#{self.vehicle_color}\""
      line << "\"#{self.department}\""
      line << "\"#{self.contact_name}\""
      line << "\"#{self.contact_phone}\""
      line << "\"#{self.purpose}\""
      line = line.join(',')
      line = line + "\n"
      lines << line
    end
    lines
  end
  
  def update_days
    unless vap_day_ids.nil?
      self.vap_request_days.each do |vrd|
        vrd.destroy unless vap_day_ids.include?(vrd.vap_day_id.to_s)
        vap_day_ids.delete(vrd.day_id.to_s)
      end
      vap_day_ids.each do |vd|
        self.vap_request_days.create(:vap_day_id => vd) unless vd.blank?
      end
      reload
    end
  end
      
  def validate
    if self.vap_day_ids.empty?
      errors.add_to_base("You must select at least one day.")
    end
  end

  HUMANIZED_ATTRIBUTES = {
    :department => "Receiving department",
    :vap_purpose_other => "Delivery purpose",
    :vap_vehicle_type_other => "Vehicle type"
  }
  
  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  def initialize(params = nil)
    super
    if self.delivery_time.nil?
      self.delivery_time = DateTime.parse("1/1/1970 08:00 AM")
    end
    if self.vap_day_ids.nil?
      self.vap_day_ids = []
    end
  end
    
  def before_save
    # we only have one access (map/directions) for now
    self.vap_access_id = 1
    self.permalink = UUID.timestamp_create().to_s
    true
  end
    
  def to_param
    permalink
  end
    
  def self.find_by_param(*args)
    find_by_permalink(*args)
  end
    
  def purpose
    if vap_purpose_id && vap_purpose_id > 0 && vap_purpose
      return vap_purpose.name
    end
    return vap_purpose_other
  end

  def vehicle_type
    if vap_vehicle_type_id && vap_vehicle_type_id > 0 && vap_vehicle_type
      return vap_vehicle_type.name
    end
    return vap_vehicle_type_other
  end
    
  def access
    return vap_access.name
  end    
end
