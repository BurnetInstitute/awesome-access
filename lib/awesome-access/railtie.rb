module AwesomeAccess
  class Railtie < Rails::Railtie
    initializer 'awesome-access' do |app|
      ActiveSupport.on_load :active_record do
        include AwesomeAccess::ActiveRecord
      end
      ActiveSupport.on_load :action_controller do
        include AwesomeAccess::ActionController
      end
    end
  end
end
