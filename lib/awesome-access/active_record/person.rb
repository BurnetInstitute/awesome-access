# TODO: Merge all identifier, id and object methods into one. Determine type based on input.

module AwesomeAccess
  module ActiveRecord

    module PersonClassMethods
      def awesome_accessify_person
        include PersonInstanceMethods

        has_secure_password
        has_and_belongs_to_many :roles

        validates :password, presence: {on: :create}, confirmation: true, length: {minimum: 6}, allow_blank: true,  reduce: true
        validates :email, presence: true, uniqueness: true, email: {allow_blank: true}, reduce: true
        validates :password_confirmation, presence: true, if: Proc.new { |p| ! p.password.blank? }, reduce: true

        after_update :deliver_password_reset_notification
      end

      module PersonInstanceMethods
        # By identifier
        def roles_as_indentifier
          roles = []
          self.roles.where(active: true).load.each do |role|
            roles << role.identifier
          end
          roles
        end

        def has_role?(indentifier)
          return true if self.roles_as_indentifier.include? 'administrator'
          self.roles_as_indentifier.include? indentifier
        end

        def has_roles?(indentifiers)
          return true if has_role? 'administrator'
          indentifiers.each do |indentifier|
            return false unless self.has_role? indentifier
          end
          true
        end

        def has_at_least_one_role?(indentifiers)
          return true if has_role? 'administrator'
          indentifiers.each do |indentifier|
            return true if self.has_role? indentifier
          end
          false
        end

        # By role ids
        def roles_as_id
          roles = []
          self.roles.where(active: true).load.each do |role|
            roles << role.id
          end
          roles
        end

        # Used by awesome-forms collection checkbox. TODO: Change in awesome-forms?
        def has_role_id? (id)
          self.role_ids.include? id
        end

        def has_role_by_id? (id)
          self.role_ids.include? id
        end

        def has_roles_by_id? (ids)
          return true if has_role? 'administrator'
          ids.each do |id|
            return false unless self.has_role_by_id? id
          end
          true
        end

        def has_at_least_one_role_by_id?(ids)
          return true if has_role? 'administrator'
          ids.each do |id|
            return true if self.has_role_by_id? id
          end
          false
        end

        # By role objects
        def roles_as_object
          roles = []
          self.roles.where(active: true).load.each do |role|
            roles << role
          end
          roles
        end

        def has_role_by_object? (object)
          self.role_ids.include? object.id
        end

        def has_roles_by_objet? (objects)
          return true if has_role? 'administrator'
          objects.each do |object|
            return false unless self.has_role_by_object? object
          end
          true
        end

        def has_at_least_one_role_by_object?(objects)
          return true if has_role? 'administrator'
          objects.each do |object|
            return true if self.has_role_by_object? object
          end
          false
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
      end # InstaceMethodsPerson
    end # ClassMethods

  end # ActiveRecord
end # AwesomeAccess
