# This class is very heavily inspired by Thoughtbot's
# HoptoadNotifier::Configuration class
class Whistle::Configuration
  URL_TEMPLATE = "%s://%s.%s.api-v%s.%s/"

  class Incomplete < Exception; end

  attr_accessor :account_key
  attr_accessor :application_key
  attr_accessor :api_key
  attr_accessor :host
  attr_accessor :secure
  attr_accessor :url
  attr_accessor :http_open_timeout
  attr_accessor :http_read_timeout
  attr_accessor :environment_name
  attr_accessor :development_environments
  attr_accessor :api_version

  alias_method :secure?, :secure

  def initialize
    @secure = false
    @host = 'incoming.whistleapp.com'
    @api_version = "1"
    @development_environments = %w||
    @sender = Whistle::Sender
    @queuer = Whistle::Queuer::Immediate
  end

  def protocol
    secure?() ? 'https' : 'http'
  end

  def url
    @url ||= default_url
  end

  def default_url
    raise Incomplete unless valid?
    URL_TEMPLATE % [protocol, api_key, account_key, api_version, host]
  end

  def valid?
    environment_name && application_key && account_key && api_key ? true : false
  end

  def development?
    development_environments.include?(environment_name)
  end

  def sender=(value)
    @sender_instance, @sender = nil, value
  end

  def sender
    @sender_instance ||= @sender.new(self)
  end

  def queuer=(value)
    @queuer_instance, @queuer = nil, value
  end

  def queuer
    @queuer_instance ||= @queuer.new(self)
  end
end
