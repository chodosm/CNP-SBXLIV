module FlowHelper
  def order_link(event_id = SBXLII_EVENT_ID, m = 'detail_step0', parking_type = '', num_people = '1')
    "#{EVENTS_URL}?m=#{m}&event_id=#{event_id}&parking_type=#{parking_type}&num_people=#{num_people}"
  end

  COLORS = ['green', 'orange', 'red', 'yellow']
  WEIRD_NAMES = 
	{
	'Red N' => 'red',
	'Stadium Permit Parking' => 'stadium',
	'Media Permit Parking' => 'media',
	'Volunteer Permit Parking' => 'volunteer'
	 }

  def color_from_string(str)
    return WEIRD_NAMES[str] if WEIRD_NAMES.keys.index(str)
    return str.downcase if COLORS.index(str.downcase)
    COLORS[str.split(//).inject(0){|x,y| x + y[0]}%4]
  end

  def map_name_from_lot(lotname)
    "#{color_from_string(lotname)}_lot.pdf"
  end

  def directions_name_from_lot(lotname)
    "directions_#{color_from_string(lotname)}"
  end
  
  def oldparam(name)
    return nil unless flash[:oldparams]
    flash[:oldparams][name]
  end
  
end
