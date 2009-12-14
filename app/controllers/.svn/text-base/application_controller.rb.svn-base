# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  include AuthenticatedSystem
  
  # Pick a unique cookie name to distinguish our session data from others'
  #session :session_key => '_ParkingDemandTool_session_id'
  
  protected
  def render_a(status_code = 404, msg = "Unable to locate record")
    respond_to do |format|
      format.html { 
        render(:template => "shared/error#{status_code}",
               :locals => {:msg => msg},
               :status => status_code)
      }
      format.js {render(:text => "alert('#{msg}');", :status => status_code)}
      format.xml {render(:nothing => true, :status => status_code)}
    end
    return true
  end
  
end
