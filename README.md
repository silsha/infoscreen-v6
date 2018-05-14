# infoscreen v6
[Demo auf Heroku](https://infoscreen-v6.herokuapp.com/rzl)

Die sechste Version des Infoscreens für das [RaumZeitLabor](https://raumzeitlabor.de).

## Features
* [Raumstatus](https://s.rzl.so)
* RNV Stationsmonitor
* Xivelydaten (Raumtemperatur, Mitgliederanzahl, Kontostand, Paybackpunkte)
* Github (offene [tuwat](https://github.com/raumzeitlabor/rzl-tuwat) Aufgaben)
* Tumblr
* Twitter
* Nächste Veranstaltungen

![infoscreen v6 Screenshot](https://cloud.githubusercontent.com/assets/31850/15991963/6015871a-30c1-11e6-9f76-38a632d31790.png)


## Installation

```bash
gem install smashing # Install smashing
gem install bundler # Install bundler
git clone git@github.com:silsha/infoscreen-v6.git # Clone Repo
cd infoscreen-v6
bundle install
smashing start
```

## Hilfe

Das Dashboard basiert auf [Smashing](https://smashing.github.io/), dort findet ihr auch einen brauchbaren Einstieg wie Elemente (als ./widgets) unter ./dashboards eingebunden werden, bzw. was diese an Übergabeparametern aus den ./jobs und erwarten.
