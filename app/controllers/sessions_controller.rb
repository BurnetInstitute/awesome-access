class SessionsController < ApplicationController
  before_filter :restrict, only: [:destroy]

  layout 'sign_in'

  def new
    redirect_to(:root) if awesome_access_person
  end
  def create
    if authenticate(params[:email], params[:password])
      redirect_to :root
    else
      set_flash :danger, now: true
      render :new
    end
  end
  def destroy
    awesome_access_destroy
    # set_flash :notice
    redirect_to :root
  end
end

