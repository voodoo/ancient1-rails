class AuthMailer < ApplicationMailer
  def login_link(user)
    @user = user
    @token_url = token_url(token: @user.login_token)

    mail(to: @user.email, subject: "Your login link for Ancient")
  end
end