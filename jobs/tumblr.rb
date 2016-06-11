require 'net/http'
require 'json'

tumblrToken = "e3wdE5ibRMuv0DIfqKpU8cUOgnyhvUqsOvBSmb1IyvYz6fYWv1" # your Tumblr token/API Key (http://www.tumblr.com/docs/en/api/v2#auth)
tumblrUri = "raumzeitlabor.tumblr.com" # the URL of the blog on Tumblr, ex: inspire.niptech.com

SCHEDULER.every '10s', :first_in => 0 do |job|
    http = Net::HTTP.new("api.tumblr.com")
    response = http.request(Net::HTTP::Get.new("/v2/blog/#{tumblrUri}/info?api_key=#{tumblrToken}"))
    if response.code == "200"

        # Retrieve total number of posts
        data = JSON.parse(response.body)
        nbQuotes = data["response"]["blog"]["posts"].to_i
        randomNum = Random.rand(1..nbQuotes)

        # Retrieve one random post
        http = Net::HTTP.new("api.tumblr.com")
        response = http.request(Net::HTTP::Get.new("/v2/blog/#{tumblrUri}/posts/photo?api_key=#{tumblrToken}&offset=#{randomNum}&limit=1"))
        if Net::HTTPSuccess
            data = JSON.parse(response.body)
            send_event('quote', { title: data["response"]["posts"][0]["photos"][0]["alt_sizes"][0]["url"], moreinfo: tumblrUri})
        end
    end
end