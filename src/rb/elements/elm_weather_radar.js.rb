export default class ElmWeatherRadar < HTMLElement
  def initialize
    super
    
    @lat = self.get_attribute('lat')
    @lon = self.get_attribute('lon')

    @words = Language.relevant.weather_radar

    init_elm()

    @city_name    = self.query_selector('#cityName')
    @weather_icon = self.query_selector('#weatherIcon')
    @temperature  = self.query_selector('#temperature')
    @feels_like   = self.query_selector('#feelsLike')
    @humidity     = self.query_selector('#humidity')
    @wind         = self.query_selector('#wind')
  end

  def connected_callback()
    Net.curl("/api/get-weather?lat=#{@lat}&lon=#{@lon}") do |content|
      weather_obj = JSON.parse(content).weather
      subinit_elm(weather_obj)
    end
  end

  def disconnected_callback()
  end

  def init_elm()
    template = """
<div class='container my-5'>
  <h2 class='text-center'>#{@words[0]}</h2>

  <div class='row text-center mt-3'>
    <div class='col-md-6 mb-3 mx-auto'>
      <div class='card bg-light shadow'>
        <div class='card-body'>
          <h3 id='cityName' class='card-title'>Valencia</h3>
          <img id='weatherIcon' class='' src='' alt='Weather' />
          <p class='card-text'><strong>#{@words[1]}:</strong> <span id='temperature'></span></p>
          <p class='card-text'><strong>#{@words[2]}:</strong> <span id='feelsLike'></span></p>
          <p class='card-text'><strong>#{@words[3]}:</strong> <span id='humidity'></span></p>
          <p class='card-text'><strong>#{@words[4]}:</strong> <span id='wind'></span></p>
        </div>
      </div>
    </div>
  </div>
</div>
    """

    self.innerHTML = template
  end

  def subinit_elm(weather_obj)
    @city_name.inner_text = weather_obj.name

    temp_in_celsius = kelvin_to_celsius(weather_obj.main.temp)
    @temperature.inner_text = "#{temp_in_celsius} °C"
    feels_in_celsius = kelvin_to_celsius(weather_obj.main['feels_like'])
    @feels_like.inner_text = "#{feels_in_celsius} °C"

    @humidity.inner_text = "#{weather_obj.main.humidity}%"
    @wind.inner_text = "#{weather_obj.wind.speed} m/s"

    icon_code = weather_obj.weather[0].icon
    @weather_icon.src = "https://openweathermap.org/img/wn/#{icon_code}@2x.png"
  end

  def kelvin_to_celsius(temperature)
    return (temperature - 273.15).to_fixed(2)
  end
end