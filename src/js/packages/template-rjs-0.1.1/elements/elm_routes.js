export default class ElmRoutes extends HTMLElement {
  constructor() {
    super();

    this._lHashchange = () => {
      return this.changePage()
    };

    this._hLanguageChange = () => {
      return this.changePage()
    };

    this._titleApp = document.title;
    this.changePage()
  };

  connectedCallback() {
    window.addEventListener("hashchange", this._lHashchange);

    return Events.connect(
      "#app",
      Language.ENVS.languageChange,
      this._hLanguageChange
    )
  };

  disconnectedCallback() {
    window.removeEventListener("hashchange", this._lHashchange);

    return Events.disconnect(
      "#app",
      Language.ENVS.languageChange,
      this._hLanguageChange
    )
  };

  languageChange() {
    this._words = Language.relevant.titles;
    return this._words
  };

  changePage() {
    this.languageChange();
    let currentPage = this.findCurrentPage();
    if (currentPage) return this.initPage(currentPage)
  };

  findCurrentPage() {
    for (let page of ROUTES_JSON.pages) {
      if (page.endpoint !== location.hash.replace("#", "")) continue;
      return page
    };

    return null
  };

  initPage(page) {
    this.initMeta(page);
    let pageName = page.endpoint;
    let content = PAGES[pageName];
    return this.initElm(content, page)
  };

  initElm(content, page=null) {
    let template = `${`\n    ${page ? content.replace(
      "TITLE",
      this._words[page.endpoint]
    ) : null}\n    `}`;

    return this.innerHTML = template
  };

  initMeta(page) {
    let title = `${this._words[page.endpoint]} | ${this._titleApp}`;

    // Title
    document.title = title;
    return gtag("event", "search", {searchTerm: page.endpoint})
  }
}