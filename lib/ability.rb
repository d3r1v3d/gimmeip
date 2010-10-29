class Ability
    include CanCan::Ability

    def initialize(user)
        p user
        global_perms
        return if !user

        if user.role? :admin
            perms_for_admin user
        end

        perms_for_all_authenticated user
    end

    def global_perms
        can :read, Ip
    end

    def perms_for_all_authenticated(user)
        can :manage, Ip
        #can [:update, :destroy], Ip do |ip|
        #    ip.user == user
        #end
    end

    def perms_for_admin(user)
        can :manage, :all
    end
end
