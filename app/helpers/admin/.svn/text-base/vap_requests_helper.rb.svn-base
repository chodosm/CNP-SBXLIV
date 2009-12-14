module Admin::VapRequestsHelper
  def vap_request_days_column(record)
    dates = record.vap_request_days.collect do |vrd|
      h(vrd.vap_day.date.strftime("%m/%d/%Y"))
    end
    dates.sort!{|a, b| Date.parse(a) <=> Date.parse(b)}.join("<br />")
  end
end