class Whistle::Queuer::Immediate < Whistle::Queuer
  def notify(source, action, params)
    @config.sender.notify(source, action, params)
  end
end
