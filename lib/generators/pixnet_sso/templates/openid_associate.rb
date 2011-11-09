class <%= openid_model %> < ActiveRecord::Base

  def email
    extra_data['value.email']
  end

  def fullname
    extra_data['value.fullname'] or "#{extra_data['value.firstname']} #{extra_data['value.lastname']}"
  end

  def avatar
    extra_data['value.avatar'] or "http://s.pixfs.net/f.pixnet.net/comment/images/avatar-#{provider.downcase}.jpg"
  end

  def nick
    extra_data['value.nickname'] or fullname
  end

  def link
    case provider
    when "facebook"
      return extra_data['value.facebook']
    else
      return false
    end
    return false
  end

  def extra_data
    return JSON.parse(extra)
  end
end
