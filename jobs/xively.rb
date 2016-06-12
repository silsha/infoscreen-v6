require 'httparty'
require 'time'

SCHEDULER.every '20s', :first_in => 0 do |job|
  begin
    # Instatiates an empty data hash. This will store our variables and associated Xively value.
    data = {}

    # Gets data from Xively
    xively_data = HTTParty.get("https://api.xively.com/v2/feeds/42055?duration=6hours&interval=0",
      { :headers => {'X-ApiKey' => "LEWdgav5SfWUWKyOfdjv89nXDheF1mwkthusI9wWgmAN3S3o", 'Content-Type' => 'application/json' }})


    # This code assigns the variables to incoming Xively data and stores the result in a hash
    xively_data['datastreams'].each do |n|
        data[n['id']] = n
    end

    # Sends the data to the DOM.
    data.each do |key, val|
      if val['datapoints']
        datapoints = []
        val['datapoints'].each do |dpval|
          datapoints.push({x: Time.parse(dpval['at']).to_i, y: dpval['value'].to_f})
        end
      end
      send_event(key, {current: val['current_value'], points: datapoints, displayedValue: val['current_value']})
    end
  end
end