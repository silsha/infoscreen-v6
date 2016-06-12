require 'rest-client'
require 'json'
require 'date'

git_owner = "raumzeitlabor"
git_project = "rzl-tuwat"

## Change this if you want to run more than one set of issue widgets
event_name = "git_issues_labeled_defects"

## the endpoint we'll be hitting
uri = "https://api.github.com/repos/#{git_owner}/#{git_project}/issues?state=all"

SCHEDULER.every '2m', :first_in => 0 do |job|
    puts "Getting #{uri}"
    response = RestClient.get uri
    issues = JSON.parse(response.body, symbolize_names: true)

    max = issues.length
    open = 0
    issues.each do |val|
        if val[:state] == 'open'
            open += 1
        end
    end

    send_event(event_name, {value: open, max:max, min: 0})

end # SCHEDULER