class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :check_admin, only: %i[new create destroy]

  def new
    render 'admin/admin_login'
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render 'admin/admin_login'
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: t('.success')
  end
end
