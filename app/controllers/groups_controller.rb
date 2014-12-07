class GroupsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :show, :match]
  before_action :correct_user, only: [:destroy, :show, :match]

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
    @group.destroy
    flash[:danger] = 'Group deleted'
    redirect_to root_url
  end

  def show
    @group = Group.find(params[:id])
    @participant = @group.participants.build
    @participants = @group.participants.order('created_at ASC')
                          .paginate(per_page: 15, page: (params[:page]))
    @page_title = @group.name
  end

  def match
    @group.participants.each do |participant|
      potential_giftees = Participant.matchable(group: @group, part: participant)
      giftee = potential_giftees.sample
      if giftee.blank? && !@group.matched
        @group.participants.update_all(giftee_id: nil, matched: false)
        match
      end
      participant.giftee_id = giftee.id
      giftee.matched = true
      participant.save && giftee.save
    end
    p 'done'
    if @group.matched
      p 'success'
    end
    redirect_to group_path(@group)
  end

  private
  def group_params
    params.require(:group).permit(:name, :year, :limit)
  end
end
