class Admin::VapRequestDaysController < AdminController
  active_scaffold :vap_request_days do |config|
    config.columns[:vap_day].ui_type = :select
    config.actions.exclude :show, :update, :search
    config.create.link.label = "Add Date"
    config.delete.link.label = "Remove"
  end
end