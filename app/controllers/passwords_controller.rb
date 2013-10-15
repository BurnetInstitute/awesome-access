class PasswordsController < ApplicationController

  # TODO: Remove hardcoded Person model

  skip_before_filter :restrict, :load_resources
  prepend_before_filter :validate_token, only: [:edit, :update]

  layout 'sign_in'

  def new
    @person = Person.new
  end
  def create
    @person = Person.where(email: params[:email]).first_or_initialize

    set_flash(:success, now: true) and render(:show) and return if @person.persisted? and @person.reset_password

    set_flash :danger, now: true
    @person = Person.new

    render :new
  end

  def edit
    @person = Person.where(email: params[:email]).first
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
        render :update and return
      end
    end

    set_flash :danger, now: true

    render :edit
  end

  private

    def validate_token
      redirect_to root_url and return unless params[:email] and params[:password_token]
      person = Person.where(email: params[:email]).first_or_initialize
      redirect_to root_url unless person.persisted? and person.password_token == params[:password_token]
    end

end
