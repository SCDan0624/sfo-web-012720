class SessionsController < ApplicationController
  skip_before_action :authorize
  
  def new
  end

  def create
    # byebug
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:message] = "You will be successful."
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

end
