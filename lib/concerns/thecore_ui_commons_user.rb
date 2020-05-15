require 'active_support/concern'

module ThecoreUiCommonsUser
    extend ActiveSupport::Concern
    
    included do
        devise :rememberable
        devise :timeoutable, timeout_in: 30.minutes
    end
end
