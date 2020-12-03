class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from Exception, with: :error_500
  end

  def error_404
    render file: Rails.root.join('public/404.html'),
           status: 404, layout: false
  end

  def error_500(error)
    logger.error error
    logger.error error.backtrace.join("\n\n")
    render file: Rails.root.join('public/500.html'),
           status: 500, layout: false
  end

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end
end
