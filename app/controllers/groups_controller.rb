class GroupsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :show, :match]
  # before_action :correct_user, only: [:destroy, :show, :match]

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
    @group = Group.find(params[:group])
    @group.participants.each do |participant|
      potential_giftees = Participant.matchable(group: @group, part: participant)
      giftee = potential_giftees.sample
      if giftee.blank?
        @group.participants.update_all(giftee_id: nil, matched: false)
        flash[:danger] = 'No match found, please try again'
        redirect_to group_path(@group) and return
      else
        participant.giftee_id = giftee.id
        giftee.matched = true
        participant.save && giftee.save
      end
    end
    if @group.all_matched
      @group.matched = true
      @group.save
      send_emails(@group)
    end
    redirect_to group_path(@group)
  end

  private
  def group_params
    params.require(:group).permit(:name, :year, :limit)
  end

  def send_emails(group)
    group.participants.each do |part|
      GroupMailer.gifting_confirmation(part, part.giftee, @group).deliver
    end
  end
end
