module AwesomeAccess
  module ActiveRecord
    def self.included(base)
      base.extend(PersonClassMethods)
      base.extend(RoleClassMethods)
    end
  end
end
