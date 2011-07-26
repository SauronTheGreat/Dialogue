class UserMailer < ActionMailer::Base

  def welcome_email(user)
    recipients    user.email
    from          "Dialogue Admin <arijit@ptotem.com>"
    subject       "Welcome to Dialogue"
    sent_on       Time.now
    body          :user => user, :url => root_url, :chg_pwd_url => edit_user_password_url(user)
    content_type  "text/html"
  end


end
