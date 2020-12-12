module ApplicationHelper
  def load_assets_for_controller(controller, action: nil)
    if action
      stylesheet_link_tag("#{controller}/#{action}")
    else
      stylesheet_link_tag("#{controller}")
    end
  end
end
