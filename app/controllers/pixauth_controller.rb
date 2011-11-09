class PixauthController < ApplicationController
  def index
    done_site = params[:done]
    redirect_site = "http://www.pixnet.net/?done=#{CGI::escape(done_site)}"

    sso = Pixnet::SSO::App.new
    info = sso.decode_process(params[:token])

    if info["info"]
      self.current_user = sso.get_user(info["msg"]["user_name"])
      #self.current_openid_user = get_openid_user(info)

      redirect_to done_site
    else
      #Rails.logger.info(info["msg"])
      redirect_to redirect_site
    end
  end

end
