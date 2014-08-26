module AwesomeAccess::SessionsControllerConcern

  extend ActiveSupport::Concern

  included do
    before_filter :awesome_access_restrict, only: [:destroy]

    layout 'sign_in'
  end

  def new
    redirect_to(AwesomeAccess.configuration.redirect_signed_in) and return if awesome_access_person
    render AwesomeAccess.configuration.new_sessions_view_path
  end
  def create
    if awesome_access_authenticate(params[:email], params[:password])
      redirect_to AwesomeAccess.configuration.redirect_signed_in and set_flash :success
    else
      set_flash :danger, now: true
      render AwesomeAccess.configuration.new_sessions_view_path
    end
  end

  def destroy
    awesome_access_destroy
    redirect_to AwesomeAccess.configuration.redirect_signed_out and set_flash :success
  end

end
