module ApplicationHelper
  def nav_rollover(image_id, alt, controller, action)
    current = (@controller.controller_name == controller && @controller.action_name == action)
    image_tag("navbutton_#{image_id}" + (current ? '_on.gif' : '.gif'), :alt => alt, :style => "margin-botton: 5px;", :class => (current ? '' : 'rollover'))
  end
end
