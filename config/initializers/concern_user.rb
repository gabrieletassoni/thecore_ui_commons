puts "User Concern from ThecoreUiCommons"
require 'active_support/concern'

module ThecoreUiCommonsUserConcern
    extend ActiveSupport::Concern
    
    included do
        devise :trackable, :timeoutable, timeout_in: 30.minutes
    end
end
