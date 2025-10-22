class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :authorize_creator!, only: [:new, :create]
  before_action :set_invitation, only: [:destroy]
  before_action :authorize_destroy!, only: [:destroy]
  before_action :set_invitable_users, only: [:new, :create]

  def new
    @invitation = @event.invitations.build
  end
  def create
    @invitation = @event.invitations.build(invitation_params)

    if @invitation.save
      redirect_to @event, notice: 'Invitation sent successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
    @invitation.destroy
    redirect_to @event, status: :see_other, notice: 'Invitation removed.'
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

  def authorize_destroy!
    unless @event.creator?(current_user) || @invitation.attendee == current_user
      redirect_to root_path, alert: 'You are not allowed to delete.'
    end
  end

  def set_invitable_users
    @invitable_users = User.invitable_for(@event)
  end

  def invitation_params
    params.require(:invitation).permit(:user_id)
  end
end
