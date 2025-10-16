class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @invitation = current_user.invitations.build(invitation_params)

    if @invitation.save
      redirect_to invitations_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  def destroy
  end

  private

  def invitation_params
    params.require(:invitation).permit(:status)
  end
end
