require 'rails'

require 'pixnet-sso/config'
require 'pixnet-sso/helper'
require 'pixnet-sso/railtie' if defined?(Rails)
require 'pixnet-sso/app'

module Pixnet
  module SSO

    autoload :ControllerMethods, 'pixnet-sso/controller_methods'
    autoload :OpenidControllerMethods, 'pixnet-sso/openid_controller_methods'

    def self.config
      yield Pixnet::SSO::Config
    end

    class Engine < ::Rails::Engine
      config.before_eager_load { |app| app.reload_routes! }
    end

  end
end
