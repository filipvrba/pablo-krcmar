export default class ElmWeatherRadar extends HTMLElement {
  constructor() {
    super();
    this._lat = this.getAttribute("lat");
    this._lon = this.getAttribute("lon");
    this._words = Language.relevant.weatherRadar;
    this.initElm();
    this._cityName = this.querySelector("#cityName");
    this._weatherIcon = this.querySelector("#weatherIcon");
    this._description = this.querySelector("#description");
    this._temperature = this.querySelector("#temperature");
    this._humidity = this.querySelector("#humidity");
    this._wind = this.querySelector("#wind");
    this._time = this.querySelector("#time")
  };

  connectedCallback() {
    return Net.curl(
      `/api/get-weather?lat=${this._lat}&lon=${this._lon}`,

      (content) => {
        let weatherObj = JSON.parse(content).weather;
        return this.subinitElm(weatherObj)
      }
    )
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    let template = `${`
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
          <li class='p-2'>${this._words[3]}: <span id='humidity'>0%</span></li>
        </ul>
      </div>
    </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  };

  subinitElm(weatherObj) {
    this._time.innerText = this.getDate(
      weatherObj.dt,
      weatherObj.timezone
    );

    this._cityName.innerText = `${weatherObj.name}, ${weatherObj.sys.country}`;
    let tempInCelsius = this.kelvinToCelsius(weatherObj.main.temp);
    this._temperature.innerText = `${tempInCelsius} °C`;
    let feelsInCelsius = this.kelvinToCelsius(weatherObj.main.feels_like);
    this._description.innerText = `${this._words[2]} ${feelsInCelsius} °C. ${this._words[5][weatherObj.weather[0].description]}.`;
    this._humidity.innerText = `${weatherObj.main.humidity}%`;
    let rotateDeg = (weatherObj.wind.deg + 360) - 180;
    this._wind.innerHTML = `${`\n    <svg class='my-auto m-2' width='13px' data-v-47880d39='' viewBox='0 0 1000 1000' enable-background='new 0 0 1000 1000' xml:space='preserve' class='icon-wind-direction' style='transform: rotate(${rotateDeg}deg);'><g data-v-47880d39='' fill='#48484a'><path data-v-47880d39='' d='M510.5,749.6c-14.9-9.9-38.1-9.9-53.1,1.7l-262,207.3c-14.9,11.6-21.6,6.6-14.9-11.6L474,48.1c5-16.6,14.9-18.2,21.6,0l325,898.7c6.6,16.6-1.7,23.2-14.9,11.6L510.5,749.6z'></path><path data-v-47880d39='' d='M817.2,990c-8.3,0-16.6-3.3-26.5-9.9L497.2,769.5c-5-3.3-18.2-3.3-23.2,0L210.3,976.7c-19.9,16.6-41.5,14.9-51.4,0c-6.6-9.9-8.3-21.6-3.3-38.1L449.1,39.8C459,13.3,477.3,10,483.9,10c6.6,0,24.9,3.3,34.8,29.8l325,898.7c5,14.9,5,28.2-1.7,38.1C837.1,985,827.2,990,817.2,990z M485.6,716.4c14.9,0,28.2,5,39.8,11.6l255.4,182.4L485.6,92.9l-267,814.2l223.9-177.4C454.1,721.4,469,716.4,485.6,716.4z'></path></g></svg>\n    ${weatherObj.wind.speed} m/s`}`;
    let iconCode = weatherObj.weather[0].icon;
    return this._weatherIcon.src = `https://openweathermap.org/img/wn/${iconCode}@2x.png`
  };

  kelvinToCelsius(temperature) {
    return Math.round((temperature - 273.15).toFixed(2))
  };

  getDate(unixTimestamp, timezoneOffset) {
    let options = {
      month: "short",
      day: "numeric",
      hour: "numeric",
      minute: "numeric",
      hour12: true
    };

    let date = new Date((unixTimestamp + timezoneOffset) * 1_000);
    return date.toLocaleString("en-US", options)
  }
}