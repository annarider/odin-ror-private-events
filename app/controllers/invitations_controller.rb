class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :authorize_creator!, only: [:new, :create]
  before_action :set_invitation, only: [:destroy]

  def new
    @invitation = @event.invitations.build
    @invitable_users = User.where.not(id: @event.attendees.pluck(:id) + [@event.creator_id])
  end
  def create
    @invitation = current_user.invitations.build(invitation_params)

    if @invitation.save
      redirect_to invitations_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def authorize_creator!
    unless @event.creator?(current_user)
      redirect_to root_path, alert: 'Only the event creator can invite users.'
    end
  end

  def set_invitation
    @invitation = @event.invitations.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:user_id)
  end
end
