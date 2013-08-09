Warden::Strategies.add(:password) do
  def valid?
    host = request.host
    subdomain = ActionDispatch::Http::URL.extract_subdomain(host, 1)
    subdomain.present? && params['user']
  end

  def authenticate!
    user = Subscribem::User.find_by_email(params['user']['email'])
    if user.nil?
      fail!
    else
      if user.authenticate(params['user']['password'])
        success!(user)
      else
        fail!
      end
    end
  end
end