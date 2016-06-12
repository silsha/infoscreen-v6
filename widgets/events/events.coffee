Batman.mixin Batman.Filters,

  startText: (str_start)->
    moment.locale('de')
    now = moment.utc()
    start = moment.unix(str_start)
    "#{start.from(now)}"

class Dashing.Events extends Dashing.Widget