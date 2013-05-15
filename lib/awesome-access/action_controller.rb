module AwesomeAccess
  module ActionController
    private

      def restrict
        redirect_to new_session_path unless awesome_access_person
      end

      def authenticate(email, password)
          if person = Person.find_by_email(email).try(:authenticate, password)
            session[:awesome_access] = {}
            session[:awesome_access][:person_id] = person.id
            return true
          end
          false
      end

      def awesome_access_person
        return @awesome_access_person ||= Person.find(session[:awesome_access][:person_id]) if session[:awesome_access]
      end

      def awesome_access_person=(person)
        if session[:awesome_access]
          return session[:awesome_access][:person_id] = person.id
        end
        false
      end

      def awesome_access_destroy
        if session[:awesome_access]
          session[:awesome_access] = nil
          return true
        end
        false
      end

  end
end
