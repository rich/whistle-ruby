require 'net/http'
require 'net/https'

class Whistle::Sender
  URL_TEMPLATE = "%s%s/%s"

  HEADERS = {
    'Content-type'             => 'application/json',
    'Accept'                   => 'text/json, application/json'
  }

  def initialize(config)
    @config = config
  end

  def send_to_whistle(source, action, params)
    url = notice_url(source, action)

    http = Net::HTTP.new(url.host, url.port)

    http.read_timeout = @config.http_read_timeout
    http.open_timeout = @config.http_open_timeout
    http.use_ssl = @config.secure?

    response = begin
                 http.post(url.path, params.to_json, HEADERS.merge({'X-Whistle-API-Key', @config.api_key}))
               rescue TimeoutError => e
                 nil
               end
  end

  def notice_url(source, action)
    URI.parse(URL_TEMPLATE % [@config.url, source, action])
  end
end
