class InvitesController < ApplicationController

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(inviter: current_user, invited_email: params[:email], message: params[:message])
    @invite.add_invite_token
    if @invite.save
      AppMailer.send_invite_email(@invite).deliver
      flash[:notice] = "Invite sent successfuly"
      redirect_to home_path
    else
      flash[:error] = "unable to send invite"
      render :new
    end
  end
end