Batman.mixin Batman.Filters,

  timeText: (str_time)->
    str_time = str_time.split('+')
    moment.locale('de')
    now = moment.utc()
    start = moment(str_time[0], "HH-mm").add(str_time[1], 'minutes')
    if str_time[1]
      "#{start.from(now)} (+#{str_time[1]})"
    else
      "#{start.from(now)} (+?)"

class Dashing.List extends Dashing.Widget
  ready: ->
    if @get('unordered')
      $(@node).find('ol').remove()
    else
      $(@node).find('ul').remove()