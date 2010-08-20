module Whistle
  autoload :Configuration,  'whistle/configuration'
  autoload :Sender,         'whistle/sender'
  autoload :Queuer,         'whistle/queuer'

  class << self
    attr_accessor :configuration

    def configure
      self.configuration  ||= Configuration.new
      yield(self.configuration)
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
