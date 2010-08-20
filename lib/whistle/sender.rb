class Whistle::Queuer
  autoload :Immediate,    'whistle/queuer/immediate'
  autoload :Resque,       'whistle/queuer/resque'

  def initialize(config)
    @config = config
  end
end
