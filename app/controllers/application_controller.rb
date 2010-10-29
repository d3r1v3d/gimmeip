class ApplicationController < ActionController::Base
    protect_from_forgery

    rescue_from CanCan::AccessDenied do |exception|
        flash[:error] = exception.message
        redirect_to root_url
    end

    # Get all roles that are accessible by the current user's ability set
    def accessible_roles
        @accessible_roles = Role.accessible_by(current_ability, :read)
    end

    # Make the current user object available to controllers and associated views
    def get_user
        @current_user = current_user
    end

    def respond_to_not_found(*types)
        asset = self.controller_name.singularize
        action = case self.action_name
            when 'destroy' then 'delete'
            when 'promote' then 'convert'
            else self.action_name
        end

        flash[:warning] = 
            (self.action_name == 'show') ? "This #{asset} is no longer available."
                                         : "Can't #{action} the #{asset} since it's no longer available."

        respond_to do |format|
            format.html { redirect_to :action => :index                          } if types.include?(:html)
            format.js   { render(:update) { |page| page.reload }                 } if types.include?(:js)
            format.xml  { render :text => flash[:warning], :status => :not_found } if types.include?(:xml)
        end
    end
end
