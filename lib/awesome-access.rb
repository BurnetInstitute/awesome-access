require 'awesome-access/engine'
require 'awesome-access/railtie'

module AwesomeAccess
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :user_object,
      :session_object,
      :passwords_controller,
      :sessions_controller,
      :redirect_restricted,
      :redirect_signed_in,
      :redirect_signed_out,
      :redirect_invalid_token,
      :show_passwords_view_path,
      :new_passwords_view_path,
      :edit_passwords_view_path,
      :update_passwords_view_path,
      :new_sessions_view_path

    def initialize
      @user_object = nil
      @session_object = nil

      @passwords_controller = nil
      @sessions_controller = nil

      @redirect_restricted = nil
      @redirect_signed_in = nil
      @redirect_signed_out = nil
      @redirect_invalid_token = nil

      @show_passwords_view_path = nil
      @new_passwords_view_path = nil
      @edit_passwords_view_path = nil
      @update_passwords_view_path = nil
      @new_sessions_view_path = nil
    end
  end
end
