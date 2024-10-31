export default class ElmRoutes extends HTMLElement {
  constructor() {
    super();

    this._lHashchange = () => {
      return this.changePage()
    };

    this._hLanguageChange = () => {
      return this.changePage()
    };

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
    this._titles = Language.relevant.titles;
    this._meta = Language.relevant.meta;
    return this._meta
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
      this._titles[page.endpoint]
    ) : null}\n    `}`;

    return this.innerHTML = template
  };

  initMeta(page) {
    let title = `${this._titles[page.endpoint]} | ${this._meta[0]}`;

    // Title
    document.title = title;

    document.querySelector("meta[property=\"og:title\"]").setAttribute(
      "content",
      this._meta[0]
    );

    document.querySelector("meta[name=\"twitter:title\"]").setAttribute(
      "content",
      this._meta[0]
    );

    // Description
    document.querySelector("meta[name=\"description\"]").setAttribute(
      "content",
      this._meta[1]
    );

    document.querySelector("meta[property=\"og:description\"]").setAttribute(
      "content",
      this._meta[1]
    );

    document.querySelector("meta[name=\"twitter:description\"]").setAttribute(
      "content",
      this._meta[1]
    );

    // Keywords
    document.querySelector("meta[name=\"keywords\"]").setAttribute(
      "content",
      this._meta[2]
    );

    return gtag("event", "search", {searchTerm: page.endpoint})
  }
}