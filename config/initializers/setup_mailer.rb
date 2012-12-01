# -*- encoding : utf-8 -*-
options  = (YAML.load_file("#{Rails.root}/config/action_mailer.yml")[Rails.env])
ActionMailer::Base.smtp_settings = options["smtp_settings"].to_options
ActionMailer::Base.default_url_options = options["default_url_options"].to_options
if Rails.env.development?
  require File.join( Rails.root,"lib","development_mail_interceptor.rb")
  Mail.register_interceptor(DevelopmentMailInterceptor) 
end
