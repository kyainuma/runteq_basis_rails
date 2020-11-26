class Admin::BaseController < ApplicationController
  skip_before_action :require_login
  before_action :check_admin

  def check_admin
    if current_user.admin?
      render 'admin/admin'
      # redirect_to 'admin_dashboards_path'
      # redirect_to admin_login_path, success: t('.success')
    else
      redirect_to root_path, success: t('.success')
    end
  end
end
