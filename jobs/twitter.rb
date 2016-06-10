require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'bskMlutBBZVSs6U0ideukSMWI'
  config.consumer_secret = 'G5Gha6cBE7jxVVm9QYyepg4WcBKYSoKoG53RML70iHNnG3CiYK'
  config.access_token = '114430885-TLwTMPf35GSpJsMUwttspTUuECABQgm0hntxV05a'
  config.access_token_secret = 'FPneOheIAkiVdEBAMAdqM5RBtmfBlEpoRVCVv8clQLlGd'
end

search_term = URI::encode('raumzeitlabor')

SCHEDULER.every '30s', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end