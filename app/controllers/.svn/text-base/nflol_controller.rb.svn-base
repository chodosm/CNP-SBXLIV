class NflolController < ApplicationController
  
  def index
  end
  
  def validate
    event = Event.find_by_event_id(NFLOL_EVENT_ID)
    if event.access_codes.any?{|code| code.code == params[:access_code]}
      redirect_to("#{EVENTS_URL}?m=detail_step1&event_id=#{NFLOL_EVENT_ID}&access_code=#{params[:access_code]}")
    else
      flash[:notice] = "Invalid access code."
      redirect_to(nflol_path)
    end
  end
  def validate_pb
    event = Event.find_by_event_id(NFLOL_PB_EVENT_ID)
    if event.access_codes.any?{|code| code.code == params[:access_code]}
      redirect_to("#{EVENTS_URL}?m=detail_step1&event_id=#{NFLOL_PB_EVENT_ID}&access_code=#{params[:access_code]}")
    else
      flash[:notice] = "Invalid access code."
      redirect_to(nflol_path)
    end
  end
end
