export default class ElmWeatherRadar < HTMLElement
  def initialize
    super
    
    @lat = self.get_attribute('lat')
    @lon = self.get_attribute('lon')

    @words = Language.relevant.weather_radar

    init_elm()

    @city_name    = self.query_selector('#cityName')
    @weather_icon = self.query_selector('#weatherIcon')
    @description  = self.query_selector('#description')
    @temperature  = self.query_selector('#temperature')
    @humidity     = self.query_selector('#humidity')
    @wind         = self.query_selector('#wind')
    @time         = self.query_selector('#time')
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
<div class='container'>
  <div class='col-md-6 mb-3 mx-auto text-center'>
    <div class=''>
      <span style='color: #eb6e4b;' id='time'>Oct 0, 00:00am</span>
      <h2 id='cityName'></h2>
    </div>
    <div>
      <div class='d-flex mb-3 justify-content-center'>
        <img id='weatherIcon' src='https://openweathermap.org/img/wn/01d@2x.png' width='50px' height='50px'>
        <p class='h1 m-0 my-auto' id='temperature'>0 °C</p>
      </div>
      <div class=''>
        <p class='m-0'><strong id='description'></strong></p>
        <ul class='d-flex flex-wrap list-unstyled justify-content-center'>
          <li class='p-2' id='wind'>0.0 m/s</li>
          <li class='p-2'>#{@words[3]}: <span id='humidity'>0%</span></li>
        </ul>
      </div>
    </div>
  </div>
</div>
    """

    self.innerHTML = template
  end

  def subinit_elm(weather_obj)
    @time.inner_text = get_date(weather_obj.dt, weather_obj.timezone)
    @city_name.inner_text = "#{weather_obj.name}, #{weather_obj.sys.country}"

    temp_in_celsius = kelvin_to_celsius(weather_obj.main.temp)
    @temperature.inner_text = "#{temp_in_celsius} °C"
    feels_in_celsius = kelvin_to_celsius(weather_obj.main['feels_like'])

    @description.inner_text = "#{@words[2]} #{feels_in_celsius} °C. #{@words[5][weather_obj.weather[0].description]}."

    @humidity.inner_text = "#{weather_obj.main.humidity}%"
    @wind.innerHTML = """
    <svg class='my-auto m-2' width='13px' data-v-47880d39='' viewBox='0 0 1000 1000' enable-background='new 0 0 1000 1000' xml:space='preserve' class='icon-wind-direction' style='transform: rotate(#{weather_obj.wind.deg}deg);'><g data-v-47880d39='' fill='#48484a'><path data-v-47880d39='' d='M510.5,749.6c-14.9-9.9-38.1-9.9-53.1,1.7l-262,207.3c-14.9,11.6-21.6,6.6-14.9-11.6L474,48.1c5-16.6,14.9-18.2,21.6,0l325,898.7c6.6,16.6-1.7,23.2-14.9,11.6L510.5,749.6z'></path><path data-v-47880d39='' d='M817.2,990c-8.3,0-16.6-3.3-26.5-9.9L497.2,769.5c-5-3.3-18.2-3.3-23.2,0L210.3,976.7c-19.9,16.6-41.5,14.9-51.4,0c-6.6-9.9-8.3-21.6-3.3-38.1L449.1,39.8C459,13.3,477.3,10,483.9,10c6.6,0,24.9,3.3,34.8,29.8l325,898.7c5,14.9,5,28.2-1.7,38.1C837.1,985,827.2,990,817.2,990z M485.6,716.4c14.9,0,28.2,5,39.8,11.6l255.4,182.4L485.6,92.9l-267,814.2l223.9-177.4C454.1,721.4,469,716.4,485.6,716.4z'></path></g></svg>
    #{weather_obj.wind.speed} m/s"""

    icon_code = weather_obj.weather[0].icon
    @weather_icon.src = "https://openweathermap.org/img/wn/#{icon_code}@2x.png"
  end

  def kelvin_to_celsius(temperature)
    return Math.round( (temperature - 273.15).to_fixed(2) )
  end

  def get_date(unix_timestamp, timezone_offset)
    options = {
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: 'numeric',
      hour12: true,
    }

    date = Date.new (unixTimestamp + timezoneOffset) * 1000
    return date.to_locale_string('en-US', options)
  end
end