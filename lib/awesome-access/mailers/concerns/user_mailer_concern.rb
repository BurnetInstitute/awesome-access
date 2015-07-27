module AwesomeAccess::UserMailerConcern

  extend ActiveSupport::Concern

  included do
    default from: 'Awesome Access <no-reply@nowhere.local>'
  end

  def awesome_access_password_reset(person)
    @person = person
    mail to: @person.email, subject: 'Reset your password', template_path: AwesomeAccess.configuration.password_reset_mailer_folder_path
  end

end
