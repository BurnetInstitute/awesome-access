require 'awesome-access/engine'
require 'awesome-access/railtie'

require 'awesome-access/mailers/concerns/user_mailer_concern'

module AwesomeAccess
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :user_model,
      :session_model,
      :passwords_controller,
      :sessions_controller,
      :user_mailer,
      :redirect_restricted,
      :redirect_signed_in,
      :redirect_signed_out,
      :redirect_invalid_token,
      :show_passwords_view_path,
      :new_passwords_view_path,
      :edit_passwords_view_path,
      :update_passwords_view_path,
      :new_sessions_view_path,
      :password_reset_view_folder_path

    def initialize
      @user_model = nil
      @session_model = nil

      @passwords_controller = nil
      @sessions_controller = nil

      @user_mailer = nil

      @redirect_restricted = nil
      @redirect_signed_in = nil
      @redirect_signed_out = nil
      @redirect_invalid_token = nil

      @show_passwords_view_path = '/awesome_access/passwords/show'
      @new_passwords_view_path = '/awesome_access/passwords/new'
      @edit_passwords_view_path = '/awesome_access/passwords/edit'
      @update_passwords_view_path = '/awesome_access/passwords/update'
      @new_sessions_view_path = '/awesome_access/sessions/new'

      @password_reset_view_folder_path = 'awesome_access/user_mailer'
    end
  end
end
