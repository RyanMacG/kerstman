class SessionsController < ApplicationController

  def new
    @page_title = 'Sign in'
  end

  def create
    session = params[:session]
    user = User.find_by(email: session[:email].downcase)
    if user && user.authenticate(session[:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      @page_title = 'Sign in'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
