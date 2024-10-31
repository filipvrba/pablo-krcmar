import csObj from "../../json/languages/cs.json";
import enObj from "../../json/languages/en.json";
import esObj from "../../json/languages/es.json";

export default class Language {
  static get relevant() {
    let codeLang = Language.get || navigator.language.split("-")[0];

    switch (codeLang) {
    case "cs":
      Language.setDocumentLang(codeLang);
      return csObj;

    case "en":
      Language.setDocumentLang(codeLang);
      return enObj;

    case "es":
      Language.setDocumentLang(codeLang);
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
  };

  static setDocumentLang(langCode) {
    return document.documentElement.lang = langCode
  }
};

Language.ENVS = {languageChange: "lang0"};
window.Language = Language