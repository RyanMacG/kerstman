class UsersController < ApplicationController
  before_action :signed_in_user,
                :correct_user,
                only: [:edit, :update]

  def new
    @page_title = 'Sign Up'
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @page_title = @user.name
  end

  def edit
    @page_title = 'Update profile'
  end

  # CRUD methods
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Account created, welcome!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash.now[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
