Pixnet::SSO.config do |config|
  config.user_model   = '<%= user_model.classify %>'
  config.sso_key = ENV['SSO_KEY']
  config.sso_secret = ENV['SSO_SECRET']
<% if openid_enabled? -%>
  config.openid_model = '<%= openid_model.classify %>'
  config.openid_enabled = <%= openid_enabled? ? 'true' : 'false' %>
<% end -%>
end
