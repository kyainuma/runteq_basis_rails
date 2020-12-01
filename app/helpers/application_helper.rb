module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
                   'RUNTEQ BOARD APP(管理画面)'
                 else
                   'RUNTEQ BOARD APP'
                 end
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def active_controller?(controller_name)
    params[:controller] == controller_name ? 'active' : nil
  end
  def active_controllers?(controller_names)
    controller_names.include?(params[:controller]) ? 'active' : nil
  end
  def active_action?(action_name)
    params[:action] == action_name ? 'active' : nil
  end
  def active_actions?(action_names)
    action_names.include?(params[:action]) ? 'active' : nil
  end
  def active_controller_and_action?(controller_name, action_name)
    if params[:controller] == controller_name && params[:action] == action_name
      return 'active'
    end
    nil
  end
end
