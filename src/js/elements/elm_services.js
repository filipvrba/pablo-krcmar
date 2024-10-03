export default class ElmServices extends HTMLElement {
  constructor() {
    super();
    this._words = Language.relevant.services;

    this._detailElements = [
      {
        icon: "bi-car-front-fill",
        image: {src: "/jpg/car_01.jpg", alt: "Car rental"}
      },

      {
        icon: "bi-house-door-fill",
        image: {src: "/jpg/accommodation_01.jpg", alt: "Accommodations"}
      },

      {
        icon: "bi-bus-front-fill",
        image: {src: "/jpg/delivery_01.jpg", alt: "Delivery to locations"}
      },

      {
        icon: "bi-map-fill",
        image: {src: "/jpg/vyhled_01.jpg", alt: "Places Guide"}
      }
    ];

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
<h1 class='text-center'>${this._words[0]}</h1>
<p class='text-center'>${this._words[1]}</p>

${this.subinitElm()}
    `}`;
    return this.innerHTML = template
  };

  subinitElm() {
    let elements = [];

    this._words[2].forEach((element, i) => {
      let isOdd = (i + 1) % 2 !== 0;
      let detailObj = this._detailElements[i];
      let style = isOdd ? ["", ""] : ["order-md-2", "order-md-1"];
      let template = `${`
<div class='row mt-5'>
  <div class='col-md-6 ${style[0]}'>
    <h2>${element.name} <i class='bi ${detailObj.icon}'></i></h2>
    <p>${element.description}</p>
    <ul>
      ${this.listInitElm(element.points)}
    </ul>

    <div class='price-box mt-3 mb-3 p-3 text-center rounded-3'>
      <h3 class='fw-bold mb-0'>${element.price}</h3>
    </div>
  </div>
  <div class='col-md-6 ${style[1]}'>
    <elm-lazy-image src='${detailObj.image.src}' class='rounded' alt='${detailObj.image.alt}' style='border-radius:  0.375rem;'></elm-lazy-image>
  </div>
</div>
      `}`;
      return elements.push(template)
    });

    return elements.join("")
  };

  listInitElm(points) {
    let elements = [];

    for (let point of points) {
      let template = `<li>${point}</li>`;
      elements.push(template)
    };

    return elements.join("")
  }
}