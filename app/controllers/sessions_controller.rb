class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  layout 'login_basic', only: %i[ new create ]

  def new; end

  def create
    @user = login(session_params[:email], session_params[:password])
    if @user
        redirect_to user_path(@user)
    else
        render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
