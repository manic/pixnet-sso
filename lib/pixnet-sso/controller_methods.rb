module Pixnet
  module SSO
    module ControllerMethods
      def logged_in?
        !!current_user
      end

      def current_user
        if Pixnet::SSO::Config.version == 1
          @current_user ||= login_from_session unless @current_user == false
        else
          @current_user ||= login_from_cookie unless @current_user == false
        end
      end

      def current_user=(new_user)
        session[:user_id] = new_user ? new_user.id : nil
        @current_user = new_user || false
      end

      def login_from_session
        self.current_user = Pixnet::SSO::Config.user_klass.find(session[:user_id]) if session[:user_id]
      end

      def login_from_cookie
        pixdata = get_login_user
        if pixdata
          sso = Pixnet::SSO::App.new
          self.current_user = sso.get_user(pixdata['user_name'])
        else
          self.current_user = nil
        end
      end

      def login_required
        if logged_in?
          return true
        else
          redirect_to root_path
          return false
        end
      end

      # sso2
      def get_login_user(type = 'pixnet')
        pixdata = cookies['pixdata'] ? JSON::parse(cookies['pixdata']) : nil
        if (!pixdata or !pixdata['sig'])
          return nil
        end
        sig = pixdata['sig']
        str = cookies['pixdata'].gsub(/,"sig":\d+/, '')
        crc32 = Zlib.crc32("#{str}#{pixdata['nonce']}#{Pixnet::SSO::Config.sso_secret}")
        return nil unless sig == crc32
        return pixdata if 'pixnet' == type && pixdata['user_name']
        return pixdata if 'openid' == type && pixdata['openid']
        return nil
      end

      def self.included(base)
        base.helper_method :logged_in?
        base.helper_method :current_user
        base.helper_method :login_required #sso1
        base.helper_method :redirect_back_or_default
        base.helper_method :get_login_user
      end
    end
  end
end
