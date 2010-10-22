class Verifier < ActionMailer::Base
  helper :application

  def verify_email(user, validation_code)
    if user.usertype == TYPE_ADMINISTRATOR
      email = user.people.emailaddress
    elsif user.usertype == TYPE_STUDENT
      email = user.people.emailaddress
    elsif user.usertype == TYPE_FACULTY
      email = user.people.emailaddress
    end
    
    from "Internship Department Admin"
    recipients email
    subject "Please revisit our web site and create new password"
    body :user => user, :validation_code => validation_code
  end
end
