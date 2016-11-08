require 'rest-client'
require 'json'
require 'date'

git_owner = "raumzeitlabor"
git_project = "rzl-tuwat"

## Change this if you want to run more than one set of issue widgets
event_name = "git_issues_labeled_defects"

## the endpoint we'll be hitting
uri = "https://api.github.com/repos/#{git_owner}/#{git_project}"

SCHEDULER.every '2m', :first_in => 0 do |job|
    puts "Getting #{uri}"
    response = RestClient.get uri
    issues = JSON.parse(response.body, symbolize_names: true)


    send_event(event_name, {current: issues[:open_issues_count]})

end # SCHEDULER