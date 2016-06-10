require 'net/http'
require 'uri'
require 'json'

url = URI.parse("http://rnv.the-agent-factory.de:8080/easygo2/rest/regions/rnv/modules/stationmonitor/element?mode=DEP&uiSource=IGNORE&time=null&hafasID=2359")

SCHEDULER.every '30s', :first_in => 0 do |job|
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Get.new(url.request_uri)
    req.add_field('EasyGO-Client-ID', '3077333226')
    req.add_field('User-Agent', 'easy.GO Client iPhone v1.3.1_RNV_Start.Info_1.3.1 (RNV Start.Info 1.3.1 (iPhone/iPhone7,2/Unknown iPhone; iPhone OS 9.3.3; de_US))')

    res = Net::HTTP.new(url.host, url.port).start do |http|
        http.request(req)
    end

    # Convert to JSON
    j = JSON.parse(res.body)

    send_event("rnv", { deps: j["listOfDepartures"] })
end