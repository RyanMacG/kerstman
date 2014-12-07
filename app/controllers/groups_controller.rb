class GroupsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index]

  def index
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      flash[:success] = 'Group created!'
      redirect_to @group
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def show
    @group = Group.find(params[:id])
  end

  private
  def group_params
    params.require(:group).permit(:name, :year, :limit)
  end
end
