class Verifier < ActionMailer::Base
  helper :application

  def verify_email(user, validation_code, validity_period)
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
    body :user => user, :validation_code => validation_code, :validaty_period => validity_period
  end
  
  def need_amend(content, content_detail, reason)
    people = content.site_review.internship.student.people
    email = people.emailaddress
    
    from "Internship Department Admin"
    recipients email
    subject "Please revisit our web site and amend your review"
    body :content_detail => content_detail, :reason => reason, :people => people
  end
  
  def set_new_status(content, content_detail, status)
    people = content.site_review.internship.student.people
    email = people.emailaddress
    
    from "Internship Department Admin"
    recipients email
    subject "Your review has been "+status
    body :content_detail => content_detail, :people => people, :status => status
  end
end
