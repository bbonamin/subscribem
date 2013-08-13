require_dependency "subscribem/application_controller"

module Subscribem
  class Account::UsersController < ApplicationController
    def new
      @user = Subscribem::User.new
    end

    def create
      account = Account.find_by_subdomain!(request.subdomain)
      user = account.users.new(user_params)
      if user.save
        force_authentication!(account, user)
        flash[:success] = 'You have signed up successfully.'
        redirect_to root_path
      else
        flash[:error] = 'Sorry, your user account could not be created.'
        render :new
      end
    end

    private
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
  end
end
