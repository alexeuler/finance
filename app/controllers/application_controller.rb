class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :require_admin
  helper_method :admin?

  def default_url_options(options={})
    {:locale => I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def admin?
    user_signed_in? && current_user.admin?
  end

  def require_admin
    render text: t('errors.messages.admin_required') unless admin?
  end

end
