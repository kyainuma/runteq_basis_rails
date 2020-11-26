class  Admin::DashboardsController < Admin::BaseController
#  skip_before_action :check_admin, only: %i[index]

  def index
    render 'admin/admin'
  end

  private

  def admin_title
    
  end
  def page_title(page_title = '')
    base_title = 'RUNTEQ BOARD APP'

    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

end
