import csObj from "../../json/languages/cs.json";

export default class Language {
  static get relevant() {
    // TODO: Kód jazyka má být dynamicky orientovaný
    //       podle nastavení prohlížeče.
    let codeLang = "cs";

    switch (codeLang) {
    case "cs":
    case "cs-CZ":
      return csObj;

    default:
      return csObj
    }
  }
};

window.Language = Language