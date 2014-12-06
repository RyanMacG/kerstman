class UsersController < ApplicationController
  def new
    @page_title = 'Sign Up'
    @user = User.new
  end
end
