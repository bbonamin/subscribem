Warden::Strategies.add(:password) do
  def subdomain
    ActionDispatch::Http::URL.extract_subdomain(request.host, 1)
  end
  def valid?
    subdomain.present? && params['user']
  end
  def authenticate!
    account = Subscribem::Account.find_by_subdomain(subdomain)
    if account
      user = account.users.find_by_email(params['user']['email'])
      if user.nil?
        fail!
      else
        if user.authenticate(params['user']['password'])
          success!(user)
        else
          fail!
        end
      end
    else
      fail!
    end
  end
end