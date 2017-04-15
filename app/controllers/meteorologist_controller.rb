require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address.gsub(" ","+")
    # raw_data = open(url).read
    parsed_data = JSON.parse(open(url).read)

    lati = parsed_data["results"][0]["geometry"]["location"]["lat"]
    long  = parsed_data["results"][0]["geometry"]["location"]["lng"]

    weatherurl = "https://api.darksky.net/forecast/1ff13afb56cb6ec60a502c54fff1f940/"+lati.to_s+","+long.to_s
    # raw_data = open(weatherurl).read
    weather_parsed_data = JSON.parse(open(weatherurl).read)



    @current_temperature = weather_parsed_data["currently"]["temperature"]

    @current_summary = weather_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = weather_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = weather_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = weather_parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
