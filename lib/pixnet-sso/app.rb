# encoding: utf-8
require 'openssl'
require 'open-uri'

module Pixnet
  module SSO
    class App
      def initialize
        @error_message = ""
      end

      def decode_process(token)
        signature = crate_signature(token)
        message = parse_json_request(token, signature)
        return check_status(message)
      end

      def get_user(user_name)
        user = Pixnet::SSO::Config.user_klass.find_or_initialize_by_login(user_name)
        if user_name.blank?
          return false
        else
          if user.new_record?
            user.save(false)
          end

          return user
        end
      end

      def get_openid_user(info)
        return false if info['msg']['openid'].blank?
        openid_user = Pixnet::SSO::Config.openid_klass.find_or_initialize_by_openid(info['msg']['openid'])
        if openid_user.new_record?
          openid_user.provider = info['msg']['openid_type']
          openid_user.extra = info['msg']['openid_data'].to_json
          openid_user.save
        end
        return openid_user
      end

      def show_error
        return @error_message
      end

      protected

      def crate_signature(token)
        digest = OpenSSL::Digest::Digest.new('sha256')
        return OpenSSL::HMAC.hexdigest(digest, Pixnet::SSO::Config.sso_secret, "#{Pixnet::SSO::Config.sso_key}#{token}").to_s
      end

      def parse_json_request(token, signature)
        message_url = "https://api.pixnet.cc/api/getssodata.php?key=#{CGI::escape(Pixnet::SSO::Config.sso_key)}&token=#{CGI::escape(token)}&sig=#{CGI::escape(signature)}"
        json_object = open(message_url).read
        message = JSON::parse(json_object)
        return message
      end

      def check_status(message)
        if message["code"] == 200
          return {"info" => true, "msg" => message["data"]}
        elsif message["code"] == 403
          @error_message = message["data"]
          return {"info" => false, "msg" => message["data"]}
        end
      end

    end
  end
end
