class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
  before_action :login_required

  private

  def login_required
    redirect_to new_session_path unless current_user
  end

  def admin_true?
    if current_user.admin != true
        redirect_to tasks_path
        @user = User.all
        flash[:notice] = '管理者以外はアクセスできません。'
    end
  end
end
