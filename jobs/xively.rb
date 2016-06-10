require 'httparty'

SCHEDULER.every '1m', :first_in => 0 do |job|
  begin
    # Instatiates an empty data hash. This will store our variables and associated Xively value.
    data = {}

    # Gets data from Xively
    xively_data = HTTParty.get("https://api.xively.com/v2/feeds/42055",
      { :headers => {'X-ApiKey' => "LEWdgav5SfWUWKyOfdjv89nXDheF1mwkthusI9wWgmAN3S3o", 'Content-Type' => 'application/json' }})


    # This code assigns the variables to incoming Xively data and stores the result in a hash
    xively_data['datastreams'].each do |n|
        data[n['id']] = n['current_value']
    end

    # Sends the data to the DOM.
    data.each do |key, val|
      send_event(key, {current: val})
    end
  end
end