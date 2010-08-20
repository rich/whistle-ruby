class Whistle::Queuer::Resque < Whistle::Queuer
  @queue = 'whistle_notices'

  def notify(source, action, params)
    Resque.enqueue(self.class, source, action, params)
  end

  def self.perform(source, action, params)
    Whistle.sender.send_to_whistle(source, action, params)
  end
end
