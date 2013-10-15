module AwesomeAccess
  module ActiveRecord

    module RoleClassMethods
      def awesome_accessify_role
        awesome_treeify

        has_and_belongs_to_many :people

        # Associations for tree
        belongs_to :parent, class_name: "Role"
        has_many :children, class_name: "Role", foreign_key: 'parent_id'

        # Validations
        validates :name, presence: true, uniqueness: true
        validates :identifier, presence: true, uniqueness: true
        validates :description, presence: true
      end
    end # ClassMethods

  end # ActiveRecord
end # AwesomeAccess

