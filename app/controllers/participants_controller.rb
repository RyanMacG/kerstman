class ParticipantsController < ApplicationController
  before_action :signed_in_user,  only: [:create, :edit, :index]

  def create
    @participant = Participant.new(participant_params)
    flash[:success] = 'participant created!' if @participant.save
    redirect_to group_path(@participant.group)
  end

  def destroy
    group = @participant.group
    @participant.destroy
    flash[:error] = 'participant deleted'
    redirect_to group_path(group)
  end

  def edit
    @page_title = 'Update participant'
    @participant = Participant.find(params[:id])
    @other_participants = Participant.where(['id <> ? AND group_id = ?', @participant.id, @participant.group_id])
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(participant_params)
      @partner = Participant.find_by_id(params[:participant][:partner_id])
      @partner.partner_id = @participant.id
      @partner.save!
      flash.now[:success] = 'Profile updated'
      redirect_to @participant.group
    else
      render 'edit'
    end
  end

  private
  def participant_params
    params.require(:participant).permit(:name, :email, :group_id, :partner_id)
  end
end
