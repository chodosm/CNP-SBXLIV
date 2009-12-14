class PdtMailer < ActionMailer::Base
  helper :flow
  def confirmation(lot, order_id, days, params)
    images = ['images/spacer.gif', 'images/header-directions.gif', 'images/header-map.gif', 'images/downloadmap.gif', 'images/header-parkingreg.gif', 'images/pillbox-topleft.gif', 'images/pillbox-top.gif', 'images/pillbox-topright.gif', 'images/pillbox-left.gif', 'images/parkingpermit.gif', 'images/pillbox-right.gif', 'images/pillbox-bottomleft.gif', 'images/pillbox-bottom.gif', 'images/pillbox-bottomright.gif', 'images/cap-bug.gif']
    cid = rand(10000000000)

    recipients params[:email]
    subject "Your Venue Access Parking Confirmation (order ##{order_id})"
    from 'support@clickandpark.com'
    content_type 'multipart/alternative'

    part 'multipart/related' do |p|
      p.part :content_type => 'text/html', :body => 
        render_message('confirmation.text.html.rhtml', :lot => lot, 
        :order_id => order_id, :days => days, :oldparams => params, :cid => cid)
      images.each do |image|
        p.part :content_type => 'image/gif',
          :body => File.read("#{RAILS_ROOT}/public/#{image}"),
          :filename => image,
          :transfer_encoding => 'base64',
          :headers => {'Content-Id' => "<#{cid}@#{image}>"}
      end
    end
  end
end
