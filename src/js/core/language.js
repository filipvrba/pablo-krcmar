import csObj from "../../json/languages/cs.json";
import enObj from "../../json/languages/en.json";
import esObj from "../../json/languages/es.json";

export default class Language {
  static get relevant() {
    let codeLang = Language.get || navigator.language.split("-")[0];

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
  };

  static get get() {
    return localStorage.getItem("lang") || URLParams.get("lang")
  };

  static set(codeLang) {
    URLParams.set("lang", codeLang);
    localStorage.setItem("lang", codeLang);
    return Events.emit("#app", Language.ENVS.languageChange)
  }
};

Language.ENVS = {languageChange: "lang0"};
window.Language = Language