class StatusController < ApplicationController
  def index
    render(:text => "alive", :status => 200, :layout => false)    
  end
end
