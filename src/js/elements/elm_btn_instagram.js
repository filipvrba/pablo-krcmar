export default class ElmBtnInstagram extends HTMLElement {
  constructor() {
    super();
    this._words = Language.relevant.btnInstagram;
    this.initElm()
  };

  connectedCallback() {
    return null
  };

  disconnectedCallback() {
    return null
  };

  initElm() {
    let template = `${`
<div class='instagram-link' style='text-align: center; margin-top: 20px;'>
  <a href='https://www.instagram.com/pavelkrcmarspain' target='_blank' style='display: inline-block; padding: 10px 20px; background-color: #E1306C; color: white; text-decoration: none; border-radius: 5px; font-size: 16px; font-weight: bold;'>
    <i class='bi bi-instagram'></i>
    ${this._words[0]}
  </a>
</div>
    `}`;
    return this.innerHTML = template
  }
}