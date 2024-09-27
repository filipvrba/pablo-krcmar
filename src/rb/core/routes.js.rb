import 'routesObj', '../../json/routes.json'

window.ROUTES_JSON = routes_obj

import 'errorHTML', '../../html/error.html?raw'
import 'introductionHTML', '../../html/introduction.html?raw'
import 'servicesHTML', '../../html/services.html?raw'
import 'galleryHTML', '../../html/gallery.html?raw'
import 'contactHTML', '../../html/contact.html?raw'

window.PAGES = {
  error: errorHTML,
  introduction: introductionHTML,
  services: servicesHTML,
  gallery: galleryHTML,
  contact: contactHTML,
}

class Routes
  def self.priority_pages(priority = 1)
    ROUTES_JSON.pages.select {|o| o.priority == priority}
  end
end
window.Routes = Routes