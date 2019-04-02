require 'httparty'
require 'time'

SCHEDULER.every '20s', :first_in => 0 do |job|
  begin
    # Instatiates an empty data hash. This will store our variables and associated Xively value.
    data = {}
    grafana_data = HTTParty.post('http://kunterbunt.vm.rzl/api/datasources/proxy/1/render', { :body => 'target=alias(rzl.service.heizung.temp.beamerplattform%2C%20\'Temperatur_Beamerplattform\')&target=alias(scale(rzl.service.power.hauptraum.power%2C%200.001)%2C%20\'Stromverbrauch_Hauptraum\')&from=-24h&until=now&format=json&maxDataPoints=50'})
    # This code assigns the variables to incoming Xively data and stores the result in a hash
    grafana_data.each do |n|
        data[n['target']] = n
    end

    # Sends the data to the DOM.
    data.each do |key, val|
      if val['datapoints']
        datapoints = []
        val['datapoints'].each do |dpval|
          datapoints.push({x: dpval[1], y: dpval[0].to_f})
        end
      end
      send_event(key, {current: datapoints[-1][:y], points: datapoints, displayedValue: datapoints[-1][:y].round(2), moreinfo: ""})
    end
  end
end
