module Abilities
    class ThecoreUiCommons
        include CanCan::Ability
        def initialize user
            # Main abilities file for Thecore applications
            if user.present?
                # Users' abilities
                if user.admin?
                    # Admins' abilities
                end
            end
        end
    end
end
