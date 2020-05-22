require 'active_support/concern'

module ThecoreUiCommonsUser
    extend ActiveSupport::Concern
    
    included do
        devise :database_authenticatable, :trackable, :validatable, :rememberable, :timeoutable, timeout_in: 30.minutes, authentication_keys: [:login]
        
        attr_writer :login
        
        def login
            @login || self.username || self.email
        end
        # Use login
        def self.find_first_by_auth_conditions(warden_conditions)
            puts "################################ VIENE USATO? #####################################################"
            conditions = warden_conditions.dup
            if login = conditions.delete(:login)
                where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
            elsif conditions.has_key?(:username) || conditions.has_key?(:email)
                # Case insensitive login
                conditions[:email].downcase! if conditions[:email]
                conditions[:username].downcase! if conditions[:username]
                where(conditions.to_h).first
            end
        end
    end
end
