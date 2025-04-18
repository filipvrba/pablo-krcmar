
import './packages/template-rjs-0.1.1/elements'
import './packages/gallery-rjs-0.1.0/elements'

import 'ElmHeader', './elements/elm_header'
window.custom_elements.define('elm-header', ElmHeader)

import 'ElmFooter', './elements/elm_footer'
window.custom_elements.define('elm-footer', ElmFooter)

import 'ElmWeatherRadar', './elements/elm_weather_radar'
window.custom_elements.define('elm-weather-radar', ElmWeatherRadar)

import 'ElmIntroduction', './elements/elm_introduction'
window.custom_elements.define('elm-introduction', ElmIntroduction)

import 'ElmIntroductionTourism', './elements/introduction/elm_tourism'
window.custom_elements.define('elm-introduction-tourism', ElmIntroductionTourism)

import 'ElmServices', './elements/elm_services'
window.custom_elements.define('elm-services', ElmServices)

import 'ElmContact', './elements/elm_contact'
window.custom_elements.define('elm-contact', ElmContact)

import 'ElmCmpBanner', './elements/elm_cmp_banner'
window.custom_elements.define('elm-cmp-banner', ElmCmpBanner)

import 'ElmLanguages', './elements/elm_languages'
window.custom_elements.define('elm-languages', ElmLanguages)

import 'ElmBtnInstagram', './elements/elm_btn_instagram'
window.custom_elements.define('elm-btn-instagram', ElmBtnInstagram)
