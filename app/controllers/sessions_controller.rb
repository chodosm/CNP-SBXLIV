class SessionsController < ApplicationController
  # render new.rhtml
  def new
  end

  def show
    redirect_to('/admin/vap')
  end
  
  def create
    self.current_agent = Agent.authenticate(params[:login], params[:password])
    if logged_in?
      self.current_agent.update_attribute(:last_seen, Time.now.to_i)
      redirect_back_or_default('/admin/')
      flash[:notice] = "Logged in successfully"
    else
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/admin/login')
  end
end
