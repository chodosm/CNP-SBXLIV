class Admin::VapRequestsController < AdminController

  before_filter :find_vap_request, :only => ["resend"]
  
  active_scaffold :vap_requests do |config|
    config.theme = :blue
    config.columns = [
      :id, :created_at, :vendor, :email, :vap_request_days, :driver_name, :driver_license,
      :driver_license_state, :driver_birth_date, :vehicle_type, :vehicle_color, 
      :department, :contact_name, :contact_phone, :purpose, :delivery_time_output
    ]
    config.list.columns = [:id, :vendor, :email, :vap_request_days, :delivery_time_output, 
      :driver_name, :vehicle_type, :vehicle_color, :department, :contact_name, 
      :purpose
    ]
    config.columns[:delivery_time_output].label = "Delivery Time"
    
    config.action_links.add('csv', :label => "Download as CSV", :inline => false)
    config.show.link.label = "Details"
    config.create.link.parameters = {:controller => "/vap"}
    config.create.link.action = ""
    config.create.link.label = "New Request"
    config.create.link.page = true
    config.create.link.popup = true
  end
  
  def csv
    @vap_requests = VapRequest.find(:all, :order => 'vap_requests.id',
      :include => [ :vap_purpose, :vap_vehicle_type, :vap_days])
    response.headers['Content-Type'] = "text/csv"
    response.headers['Content-Disposition'] = "attachment; filename=vap_requests-#{DateTime.now().strftime("%Y-%m-%d-%H%M")}.csv"
    render(:layout => false)
  end

  def conditions_for_collection
    ['event_id = 0']
  end
  
  def resend
    VapRequestMailer.deliver_request_received(@vap_request)
    respond_to do |format|
      format.js {render(:text => "alert('Permit successfully resent');")}
    end
  end
  
  protected
    def find_vap_request
      @vap_request = VapRequest.find(params[:id])
      render_a(404, "Unable to locate request") unless @vap_request
    end
end
