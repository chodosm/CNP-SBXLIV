class VapRequestMailer < ActionMailer::Base
  def request_received(vap_request = VapRequest.new)
    recipients  "#{vap_request.contact_name} <#{vap_request.email}>"
    from        "Click And Park <info@clickandpark.com>"
    subject     "Vehicle Access Permit Request Received"
    @cid = Time.now.to_f.to_s
    opts = { :vap_request => vap_request, :cid => @cid }

    part :content_type => "multipart/alternative" do |p|
      p.part :content_type => 'text/plain',
        :body => render_message('request_received_plain.rhtml', opts)
      p.part :content_type => 'text/html', 
        :body => render_message('request_received_html.rhtml', opts)
    end
    
    attachment :content_type => "application/pdf",
      :content_disposition => "attachment",
      :transfer_encoding => "base64",
      :filename => "vap_lots.pdf",
      :headers => { 'Content-ID' => "<#{@cid}vap_lots.pdf@clickandpark.com>" },
      :body => File.read("#{RAILS_ROOT}/public/images/maps/vap_lots.pdf")
      
  end
end