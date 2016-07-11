require 'mail'

# https://github.com/plataformatec/devise/wiki/How-to:-Use-a-custom-email-validator-with-Devise
class EmailValidator < ActiveModel::EachValidator

  def validate_each(record,attribute,value)
    begin
      m = Mail::Address.new(value)
      # We must check that value contains a domain, the domain has at least
      # one '.' and that value is an email address
      r = m.domain!=nil && m.domain.match('\.') && m.address == value

    rescue Exception => e
      r = false
    end
    record.errors[attribute] << (options[:message] || "is invalid") unless r

    # Reject temporary email address
    record.errors[attribute] << 'must be given. Please give us a real one!!!' unless value !~ User::TEMP_EMAIL_REGEX
  end
end
