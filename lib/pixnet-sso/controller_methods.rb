module Pixnet
  module SSO
    module ControllerMethods
      def logged_in?
        !!current_user
      end

      def current_user
        @current_user ||= login_from_session unless @current_user == false
      end

      def current_user=(new_user)
        session[:user_id] = new_user ? new_user.id : nil
        @current_user = new_user || false
      end

      def login_from_session
        self.current_user = User.find(session[:user_id]) if session[:user_id]
      end

      def login_required
        if logged_in?
          return true
        else
          redirect_to root_path
          return false
        end
      end


      def self.included(base)
        base.helper_method :logged_in?
        base.helper_method :current_user
        base.helper_method :login_required
        base.helper_method :redirect_back_or_default
      end
    end
  end
end
