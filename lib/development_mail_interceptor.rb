# -*- encoding : utf-8 -*-
class DevelopmentMailInterceptor  
  def self.delivering_email(message)  
    message.subject = "to:#{message.to} bcc:#{message.bcc} #{message.subject}"  
    recipient = YAML.load_file( File.join(Rails.root, "config","action_mailer.yml") )[Rails.env]['recipient']
    message.to = recipient if message.to
    message.bcc = recipient if message.bcc
  end  
end  
