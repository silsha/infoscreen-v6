require 'net/http'
require 'icalendar'
require 'open-uri'

# List of calendars
calendars = {events: "https://raumzeitlabor.de/events/ical?accept=ics"}

SCHEDULER.every '5m', :first_in => 0 do |job|

  calendars.each do |cal_name, cal_uri|

    ics  = open(cal_uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}) { |f| f.read }
    cal = Icalendar.parse(ics).first
    puts cal
    events = cal.events

    # select only current and upcoming events
    now = Time.now.utc
    events = events.select{ |e| e.dtend.to_time.utc > now }

    # sort by start time
    events = events.sort{ |a, b| a.dtstart.to_time.utc <=> b.dtstart.to_time.utc }[0..1]

    events = events.map do |e|
      {
        title: e.summary,
        start: e.dtstart.to_time.to_i,
        end: e.dtend.to_time.to_i
      }
    end

    send_event("cal_#{cal_name}", {events: events})
  end

end