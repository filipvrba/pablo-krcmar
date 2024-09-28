import weatherObj from "../../json/weather.json";

export default class ElmWeatherRadar extends HTMLElement {
  constructor() {
    super();
    this.initElm();
    this._cityName = this.querySelector("#cityName");
    this._weatherIcon = this.querySelector("#weatherIcon");
    this._temperature = this.querySelector("#temperature");
    this._feelsLike = this.querySelector("#feelsLike");
    this._humidity = this.querySelector("#humidity");
    this._wind = this.querySelector("#wind")
  };

  connectedCallback() {
    this._cityName.innerText = weatherObj.name;
    let tempInCelsius = this.kelvinToCelsius(weatherObj.main.temp);
    this._temperature.innerText = `${tempInCelsius} °C`;
    let feelsInCelsius = this.kelvinToCelsius(weatherObj.main.feels_like);
    this._feelsLike.innerText = `${feelsInCelsius} °C`;
    this._humidity.innerText = `${weatherObj.main.humidity}%`;
    this._wind.innerText = `${weatherObj.wind.speed} m/s`;
    let iconCode = weatherObj.weather[0].icon;
    return this._weatherIcon.src = `http://openweathermap.org/img/wn/${iconCode}@2x.png`
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    let template = `${`
<div class='container my-5'>
  <h2 class='text-center'>Počasí</h2>

  <div class='row text-center mt-3'>
    <div class='col-md-6 mb-3 mx-auto'>
      <div class='card bg-light shadow'>
        <div class='card-body'>
          <h3 id='cityName' class='card-title'>Valencia</h3>
          <img id='weatherIcon' class='' src='' alt='Počasí' />
          <p class='card-text'><strong>Teplota:</strong> <span id='temperature'></span></p>
          <p class='card-text'><strong>Pocitová teplota:</strong> <span id='feelsLike'></span></p>
          <p class='card-text'><strong>Vlhkost:</strong> <span id='humidity'></span></p>
          <p class='card-text'><strong>Vítr:</strong> <span id='wind'></span></p>
        </div>
      </div>
    </div>
  </div>
</div>
    `}`;
    return this.innerHTML = template
  };

  kelvinToCelsius(temperature) {
    return (temperature - 273.15).toFixed(2)
  }
}