class ApplicationController < ActionController::Base
  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!
  # helper_method :current_user

  # deviseコントローラーにストロングパラメータを追加する          
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログイン後、posts/indexに移動する
  def after_sign_in_path_for(resource)
    posts_path
  end

  # private


  protected
  def configure_permitted_parameters
    # サインアップ時にoicey_idとnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント編集の時にoicey_idとnameとself_introductionのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :self_introduction])
  end

  # def current_user
  #   # @current_userがnilならUser.find_by(id: session[:user_id]) で
  #   # セッション情報ほ検索し、代入する
  #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  # end

end
