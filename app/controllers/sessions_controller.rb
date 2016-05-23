class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:sessions][:email])

    if @user && @user.authenticate(params[:sessions][:password])
      flash[:success] = "Willkommen #{@user.name}!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:danger] = 'Username oder Passwort falsch'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
