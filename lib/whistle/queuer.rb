require 'net/http'
require 'net/https'

class Whistle::Sender
  def initialize(config)
    @config = config
  end

  def notify(source, action, params)
    
  end
end
