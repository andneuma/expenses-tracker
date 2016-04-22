class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.role = "Unapproved"

    if @user.save
      flash[:success] = "Du hast dich erfolgreich registriert!"
      redirect_to root_path
    else
      @errors = @user.errors
      flash[:danger] = "Nutzer_in konnte nicht erstellt werden!"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Änderungen erfolgreich übernommen"
      redirect_to root_path
    else
      flash[:danger] = "Änderungen konnten nicht übernommen werden!"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

end
