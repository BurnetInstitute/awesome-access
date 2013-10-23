module AwesomeAccess::PasswordsControllerConcern

  extend ActiveSupport::Concern

  # TODO: Remove hardcoded Person model

  included do
    skip_before_filter :awesome_access_restrict
    prepend_before_filter :validate_token, only: [:edit, :update]

    layout 'sign_in'
  end

  def new
    @person = Person.new
    render AwesomeAccess.configuration.new_passwords_view_path
  end
  def create
    @person = Person.where(email: params[:email]).first_or_initialize

    set_flash(:success, now: true) and render(AwesomeAccess.configuration.show_passwords_view_path) and return if @person.persisted? and @person.reset_password

    set_flash :danger, now: true
    @person = Person.new

    render AwesomeAccess.configuration.new_passwords_view_path
  end

  def edit
    @person = Person.where(email: params[:email]).first
    render AwesomeAccess.configuration.edit_passwords_view_path
  end
  def update
    @person = Person.where(email: params[:email]).first

    if ! params[:password].blank? and ! params[:password_confirmation].blank?
      @person.password = params[:password]
      @person.password_confirmation = params[:password_confirmation]

      if @person.save
        @person.password_token = nil
        @person.save
        set_flash :success, now: true
        render AwesomeAccess.configuration.update_passwords_view_path and return
      end
    end

    set_flash :danger, now: true

    render AwesomeAccess.configuration.edit_passwords_view_path
  end

  private

    def validate_token
      redirect_to AwesomeAccess.configuration.redirect_invalid_token and return unless params[:email] and params[:password_token]
      person = Person.where(email: params[:email]).first_or_initialize
      redirect_to AwesomeAccess.configuration.redirect_invalid_token unless person.persisted? and person.password_token == params[:password_token]
    end

end
