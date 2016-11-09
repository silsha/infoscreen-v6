require 'net/http'
require 'uri'
require 'JSON'

url = URI.parse("http://s.rzl.so/api/full.json")

SCHEDULER.every '30s', :first_in => 0 do |job|
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(Net::HTTP::Get.new(url.request_uri))

    # Convert to JSON
    data = JSON.parse(response.body)

    status = (data["status"] == '1' ? 'ok' : (data["status"] == '?' ? 'warning' : 'critical'))
    message = (data["status"] == '1' ? 'Geöffnet' : (data["status"] == '?' ? 'Unbekannt' : 'Geschlossen'))
    anwesend = data["details"]["laboranten"]

    send_event("status", { status: status, message: message, anwesend: anwesend })
end