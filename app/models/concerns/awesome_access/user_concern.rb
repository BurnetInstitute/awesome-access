module AwesomeAccess::UserConcern

  extend ActiveSupport::Concern

  included do
    has_secure_password

    validates :password, presence: {on: :create}, confirmation: true, length: {minimum: 6}, allow_blank: true,  reduce: true
    validates :email, presence: true, uniqueness: true, email: {allow_blank: true}, reduce: true
    validates :password_confirmation, presence: true, if: Proc.new { |p| ! p.password.blank? }, reduce: true
  end

  def reset_password
    self.password_token = SecureRandom.hex
    if self.save
      deliver_password_reset_notification
      true
    else
      false
    end
  end

  private

    def deliver_password_reset_notification
      AwesomeAccess.configuration.user_mailer.constantize.awesome_access_password_reset(self).deliver unless self.password_token.blank?
    end

end
