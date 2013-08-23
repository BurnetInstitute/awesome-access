module AwesomeAccess
  module ActiveRecord
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def awesome_accessify
        include InstanceMethods
          has_secure_password
          has_and_belongs_to_many :roles

          validates :password, presence: {on: :create}, confirmation: true, length: {minimum: 6}, allow_blank: true,  reduce: true
          validates :email, presence: true, uniqueness: true, email: {allow_blank: true}, reduce: true
          validates :password_confirmation, presence: true, if: Proc.new { |p| ! p.password.blank? }, reduce: true

          after_update :deliver_password_reset_notification
      end

      module InstanceMethods
        def has_role?(role)
          return true if self.roles_as_indentifier.include? 'administrator'
          self.roles_as_indentifier.include? role
        end

        def has_roles?(roles)
          return true if has_role? 'administrator'
          roles.each do |role|
            return false unless self.has_role? role
          end
          true
        end

        def roles_as_indentifier
          roles = []
          self.roles.where(active: true).load.each do |role|
            roles << role.identifier
          end
          roles
        end

        def has_role_id? (id)
          self.role_ids.include? id
        end

        def reset_password
          self.password_token = SecureRandom.hex
          self.save
        end

        private
        # TODO: Remove hard link to People model
          def deliver_password_reset_notification
            PeopleMailer.password_reset(self).deliver unless self.password_token.blank?
          end
      end # InstaceMethods
    end # ClassMethods

  end # ActiveRecord
end # AwesomeAccess

