import csObj from "../../json/languages/cs.json";
import enObj from "../../json/languages/en.json";
import esObj from "../../json/languages/es.json";

export default class Language {
  static get relevant() {
    let codeLang = navigator.language.split("-")[0];

    switch (codeLang) {
    case "cs":
      return csObj;

    case "en":
      return enObj;

    case "es":
      return esObj;

    default:
      return csObj
    }
  }
};

window.Language = Language