class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # nameを保存できるように変更する。
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cookie # クッキーを設定するメソッドを呼び出す

  private

  def set_cookie
    cookies[:my_cookie] = {
      value: "value_here",
      secure: true, # HTTPS通信でのみCookieを送信
      same_site: :none # サードパーティクッキーを許可
    }
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
