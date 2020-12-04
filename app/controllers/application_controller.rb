class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  unless Rails.env.development?
    # rescue_from ActionController::RoutingError,   with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    # rescue_from Exception, with: :error_500
  end

  def error_404
    render file: Rails.root.join('public', '404'),
           status: :not_found, layout: false
  end

  def error_500(error)
    logger.error error
    logger.error error.backtrace.join("\n\n")
    render file: Rails.root.join('public', '500'),
           status: :not_found, layout: false
  end

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end
end
