class AwesomeAccess::PeopleMailer < ActionMailer::Base

  default from: 'Awesome Access <no-reply@nowhere.local>'

  def password_reset(person)
    @person = person
    mail to: @person.email, subject: 'Reset your password'
  end

end
