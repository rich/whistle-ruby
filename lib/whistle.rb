module Whistle
  autoload :Configuration,  'whistle/configuration'
  autoload :Sender,         'whistle/sender'
  autoload :Queuer,         'whistle/queuer'

  attr_accessor :configuration

  class << self
    def configure(&block)
      self.configuration  ||= Configuration.new
      self.configuration.instance_eval(&block)
    end

    def queuer
      self.configuration.queuer
    end

    def sender
      self.configuration.sender
    end

    def notify(source, action, params={})
      self.queuer.notify(source, action, params)
    end
  end
end
