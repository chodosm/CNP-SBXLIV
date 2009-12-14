class AdminController < ApplicationController
  
  before_filter :login_required
  
  layout("admin")
  
  def show
    redirect_to('/admin/vap_requests')
  end
  
end