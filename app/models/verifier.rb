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
  
  def set_new_status(people, content_detail, status)
    email = people.emailaddress
    
    from "Internship Department Admin"
    recipients email
    subject "Your content has been "+status
    body :content_detail => content_detail, :people => people, :status => status
  end
  
  def comment_review(commentor_name, review, comment_text)
    owner = review.internship.student.people
    email = owner.emailaddress
    content = review.content
    content_detail = ContentVersion.find(content.latest_version_id)
    
    from "Internship Department Admin"
    recipients email
    subject commentor_name+" has commented on your review title : "+content_detail.title
    body :commentor_name => commentor_name, :owner => owner, :content_detail => content_detail, :comment_text => comment_text
  end
  
  def comment_dicussion(commentor_name, discussion, comment_text)
    owner = discussion.student.people
    email = owner.emailaddress
    content = discussion.content
    content_detail = ContentVersion.find(content.latest_version_id)
    
    from "Internship Department Admin"
    recipients email
    subject commentor_name+" has commented on your review title : "+content_detail.title
    body :commentor_name => commentor_name, :owner => owner, :content_detail => content_detail, :comment_text => comment_text
  end
end
