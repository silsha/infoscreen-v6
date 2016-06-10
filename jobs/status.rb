require 'net/http'
require 'uri'
require 'json'

url = URI.parse("http://s.rzl.so/api/simple.json")

SCHEDULER.every '5m', :first_in => 0 do |job|
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(Net::HTTP::Get.new(url.request_uri))

    # Convert to JSON

    status = (response.body == '1' ? 'ok' : 'critical')
    message = (response.body == '1' ? 'Geöffnet' : 'Geschlossen')

    send_event("status", { status: status, message: message })
end