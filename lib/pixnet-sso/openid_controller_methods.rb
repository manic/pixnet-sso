module Pixnet
  module SSO
    module OpenidControllerMethods
      def current_openid_user=(openid_user)
        session[:openid_user_id] = openid_user ? openid_user.id : nil
        @current_openid_user =  openid_user || false
      end

      def current_openid_user
        @current_openid_user ||= openid_login_from_session unless @current_openid_user == false
      end

      def openid_login_from_session
        self.current_openid_user = Pixnet::SSO::Config.openid_klass.find(session[:openid_user_id]) if session[:openid_user_id]
      end

      def self.included(base)
        base.helper_method :current_openid_user
      end
    end
  end
end
