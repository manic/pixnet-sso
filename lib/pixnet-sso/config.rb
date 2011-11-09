module Pixnet
  module SSO
    module Config
      # Name of the User class
      mattr_accessor :user_model
      @@user_model = "User"

      # SSO Key
      mattr_accessor :sso_key

      # SSO Secret
      mattr_accessor :sso_secret

      def self.user_klass
        user_model.to_s.constantize
      end
    end
  end
end