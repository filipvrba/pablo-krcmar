import routesObj from "../../json/routes.json";
window.ROUTES_JSON = routesObj;
import errorHTML from "../../html/error.html?raw";
import introductionHTML from "../../html/introduction.html?raw";
import servicesHTML from "../../html/services.html?raw";
import galleryHTML from "../../html/gallery.html?raw";
import contactHTML from "../../html/contact.html?raw";

window.PAGES = {
  error: errorHTML,
  introduction: introductionHTML,
  services: servicesHTML,
  gallery: galleryHTML,
  contact: contactHTML
};

class Routes {
  static priorityPages(priority=1) {
    return ROUTES_JSON.pages.filter(o => o.priority === priority)
  }
};

window.Routes = Routes