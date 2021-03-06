module AwesomeAccess::ActionControllerConcern

  extend ActiveSupport::Concern

  included do
  end

  private

    def awesome_access_restrict
      redirect_to AwesomeAccess.configuration.redirect_restricted unless awesome_access_person
    end

    def awesome_access_authenticate(email, password)
      if person = AwesomeAccess.configuration.user_model.constantize.where(email: email).where(active: true).first
        if person.password_digest != nil
          if person.authenticate password
            session["awesome_access"] = {}
            session["awesome_access"]["person_id"] = person.id
            if person.password_token
              person.password_token = ''
            end
            person.last_seen = DateTime.now
            person.save
            return true
          end
        end
      end
      false
    end

    def awesome_access_person
      return @awesome_access_person ||= AwesomeAccess.configuration.user_model.constantize.find(session["awesome_access"]["person_id"]) if session["awesome_access"]
    end

    def awesome_access_person=(person)
      if session["awesome_access"]
        return session["awesome_access"]["person_id"] = person.id
      end
      false
    end

    def awesome_access_destroy
      if session["awesome_access"]
        session["awesome_access"] = nil
        return true
      end
      false
    end
end
