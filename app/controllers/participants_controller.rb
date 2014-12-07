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
  end

  def update
    @participant = Participant.find(params[:id])
    remove_existing_partner(@participant)
    if @participant.update_attributes(participant_params)
      handle_partners(@participant)
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

  def handle_partners(participant)
    partner = Participant.find(participant.partner_id)
    partner.partner_id = participant.id
    partner.save
  end

  def remove_existing_partner(participant)
    participant.partner.update_attribute(:partner, nil)
    participant.update_attribute(:partner, nil)
  end
end
