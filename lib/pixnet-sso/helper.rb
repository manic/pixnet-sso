# encoding: utf-8

require 'uuid'

module Pixnet
  module SSO
    module Helper
      def pixnet_login_url
        "http://www.pixnet.net/?done=#{url_encode(request.url)}"
      end

      def pixnet_logout_url
        "http://panel.pixnet.cc/logout?done=#{url_encode(request.url)}"
      end

      def pixnet_sso_scripts
        now = Time.now.to_i.to_s
        unique = Zlib.crc32(UUID.generate).to_s
        user_name = current_user.blank? ? "" : current_user.login
        login_name = "#{user_name}.pixnet.net#{unique}#{now}"

        if Pixnet::SSO::Config.openid_enabled and current_openid_user
          login_name = "#{login_name}#{current_openid_user.openid}"
        end
        html = <<MSG
<script type="text/javascript">
  <!--
  var pix = pix || {};
  pix.apisite = 'api.pixnet.cc';
  pix.login_name = "#{Digest::MD5.hexdigest(login_name)}";
  pix.server_name = "#{URI::parse(request.host)}";
  pix.checklogin_version = 2;
  pix.checklogin_callback = '#{api_checklogin_path}';
  -->
</script>
<script src="//api.pixnet.cc/api/checklogin.php?js=1&amp;unique=#{unique}&amp;timestamp=#{now}&amp;type=2" type="text/javascript"></script>
<script src="http://s.pixfs.net/js/pixnet/checklogin.js?v=20110519" type="text/javascript"></script>
MSG
        return html.html_safe
      end

      def pixnet_sso2_scripts
        unique = Zlib.crc32(UUID.generate).to_s
        now = Time.now.to_i.to_s
        sig = Zlib.crc32("#{Pixnet::SSO::Config.sso_secret}#{unique}#{now}")
        html = <<MSG
        <script type="text/javascript" src="//checklogin.#{request.host}/login_name.php?key=#{Pixnet::SSO::Config.sso_key}&unique=#{unique}&timestamp=#{now}&sig=#{sig}"></script>
        <script type="text/javascript" src="//api.pixnet.cc/api/checklogin.php?js=1&unique=#{unique}&timestamp=#{now}&type=2"></script>
        <script type="text/javascript" src="//s.pixfs.net/js/pixnet/checklogin.min.js"></script>
MSG
        return html.html_safe
      end
    end
  end
end
