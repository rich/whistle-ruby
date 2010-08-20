class Whistle::Queuer::Immediate < Whistle::Queuer
  def notify(source, action, params)
    @config.sender.send_to_whistle(source, action, params)
  end
end
