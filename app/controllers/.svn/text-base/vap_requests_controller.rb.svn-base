class VapRequestsController < ApplicationController
  def index
    new
    render(:action => "new")
  end
  
  def show
    @vap_request = VapRequest.find_by_param(params[:id])
    render(:layout => false)
  end
  
  def new
    @vap_request = VapRequest.new(params[:vap_request])
  end
  
  def create
    @vap_request = VapRequest.new(params[:vap_request])
    @vap_request.delivery_time =  params[:delivery_time][:hour] + ':' +
                                  params[:delivery_time][:minute] + ' ' +
                                  params[:delivery_time][:meridiem]
    
    respond_to do |format|
      if @vap_request.save
        VapRequestMailer.deliver_request_received(@vap_request)
        format.html { redirect_to(vap_path(@vap_request)) }
        format.js
      else
        format.html { render(:action => "new") }
        format.js
      end
    end
  end
  
end