require 'net/http'
require 'uri'
require 'json'
require 'pp'

class PDTCheckout
  MSGS = {
    'event_day' => { :missing => 'Please select a day' },
    'postal_code' => { :missing => 'Please enter a zip/postal code' },
    'password' => { :invalid => 'That password did not match our records.  Please enter a different password.' },
    'street1' => { :missing => 'Please enter an address' }
  }

  NAMES = { # PERL => html
    'event_day' => 'days',
    'phone_number' => 'phone',
    'street1' => 'address1',
    'postal_code' => 'zip'
  }

  def self.messages(my_name) ; return MSGS[my_name] || {}; end
  def self.form_name(my_name) ; return NAMES[my_name] || my_name ; end

  def self.errors_from_pdtcheckout_response(happened)
    errors = {}
    in_errors = happened['error']
    in_errors.keys.each do |key|
      if(in_errors[key]['error_code'] == 'MISSING') then
        errors[self.form_name(key)] = self.messages(key)[:missing] || 'Please enter a ' + key
      end
      if(in_errors[key]['error_code'] == 'INVALID') then
        errors[self.form_name(key)] = self.messages(key)[:invalid] || "The #{key} you have entered is invalid"
      end
    end
    if in_errors['customer'] && in_errors['customer']['error_code'] == 'login'
      errors['password'] = self.messages('password')[:invalid]
    end
    return errors
  end

  def self.pretty_print(values,happened)
    str_err  = ''
    PP.pp(values, str_err)
    RAILS_DEFAULT_LOGGER.info("asked: " + str_err)
    PP.pp(happened, str_err)
    RAILS_DEFAULT_LOGGER.info("happened: " + str_err)
  end

  def self.values_from_form(form_params)
    days = []
    form_params.keys.each do |key|
      next unless key =~ /day/
      days << key.gsub(/^day/, '')
    end
    values = {}
# for the parking request
    values['event_id'] = form_params[:event_id]
    values['lot_id'] = form_params[:lot_id]
    values['event_day'] = days.join ','
    values['access_code'] = form_params[:access_code]
# for the customer
    values['email'] = form_params[:email]
    values['first_name'] = form_params[:firstname]
    values['last_name'] = form_params[:lastname]
    values['password'] = form_params[:password]
# for the customer address
    values['grouporg_name'] = form_params['company']
    values['street1'] = form_params['address1']
    values['street2'] = form_params['address2']
    values['city'] = form_params['city']
    values['state'] = form_params['state']
    values['phone_number'] = form_params['phone']
    values['postal_code'] = form_params['zip']
    values['country'] = 'US'
    values
  end

end

class FlowController < ApplicationController

  def select
    flash[:errors] = {} unless flash[:errors]
    begin
      @access_code = AccessCode.find_by_code(
        (flash[:oldparams] && flash[:oldparams][:access_code]) || 
        params[:access_code])
      @event = @access_code.event
      @lots = [@access_code.event_lot]
      @days_available = @access_code.days
      @days_available = 
        @days_available.delete_if{|x| x.day_start < 1.day.ago }
    rescue
      flash[:notice] = "Invalid access code."
      redirect_to('/sap')
    end
 end

  def confirm
    @application = (params[:application].nil?) ? "vap" : params[:application]
    logger.info "the application is #{@application}"
    @days = params.keys.select{|k| k =~ /daycheck/}.map{|k| k.gsub(/daycheck/,'').gsub(/_/,' ')}
    @days.sort!{|a, b| Date.parse(a + " 2008") <=> Date.parse(b + " 2008")}
    #@days = @days.delete_if{|x| Date.parse(x + " 2008") < Date.new }
    case @application
      when "vap"
        confirm_vap
      when "sap"
        confirm_sap
      else
        render(:text => "Unable to locate the requested application", :status => 404, :layout => :none)
    end
  end

  def confirm_vap
    render(:action => "confirm_vap", :layout => "confirm")
  end

  def confirm_sap
    @values = PDTCheckout.values_from_form(params)
    res = Net::HTTP.post_form(URI.parse('http://localhost:8080/apps/pdtcheckout'), @values)
    @happened = JSON.parse(res.body)
    PDTCheckout.pretty_print(@values, @happened)
    return sap_success if(@happened['result']) 
    flash[:errors] = PDTCheckout.errors_from_pdtcheckout_response(@happened)
    flash[:oldparams] = params
    redirect_to :action => 'select'
    @lot = params[:lot]
  end

  def sap_success
    @access_code = AccessCode.find_by_code(params[:access_code])
    @lot = @access_code.event_lot.lot_name
    @order_id = @happened['result']['order_id']
    @days = @values['event_day'].split(',').map{|d_id|EventDay.find(d_id).day_start.strftime("%a, %b. %d")}
    # deliver email
    PdtMailer.deliver_confirmation(@lot, @order_id, @days, params)
    render(:action => "confirm_sap", :layout => "confirm")
  end
end
