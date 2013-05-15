module AwesomeAccess
  module ActiveRecord
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def awesome_accessify
        include InstanceMethods
        private
          has_secure_password
          has_and_belongs_to_many :roles
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
      end # InstaceMethods
    end # ClassMethods

  end # ActiveRecord
end # AwesomeAccess

