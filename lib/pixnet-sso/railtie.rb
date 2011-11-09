require "pixnet-sso"

module Pixnet
  module SSO
    class Railtie < Rails::Railtie
      initializer "pixnet-sso.view_helpers" do
        ActionView::Base.send :include, Pixnet::SSO::Helper
      end
    end
  end
end