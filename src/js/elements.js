import "./packages/template-rjs-0.1.1/elements";
import "./packages/gallery-rjs-0.1.0/elements";
import ElmHeader from "./elements/elm_header";
window.customElements.define("elm-header", ElmHeader);
import ElmFooter from "./elements/elm_footer";
window.customElements.define("elm-footer", ElmFooter);
import ElmWeatherRadar from "./elements/elm_weather_radar";
window.customElements.define("elm-weather-radar", ElmWeatherRadar);
import ElmIntroduction from "./elements/elm_introduction";
window.customElements.define("elm-introduction", ElmIntroduction);
import ElmIntroductionTourism from "./elements/introduction/elm_tourism";

window.customElements.define(
  "elm-introduction-tourism",
  ElmIntroductionTourism
);

import ElmServices from "./elements/elm_services";
window.customElements.define("elm-services", ElmServices);
import ElmContact from "./elements/elm_contact";
window.customElements.define("elm-contact", ElmContact)