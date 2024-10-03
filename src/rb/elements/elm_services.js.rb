export default class ElmServices < HTMLElement
  def initialize
    super

    @words = Language.relevant.services
    @detail_elements = [
      {
        icon: 'bi-car-front-fill',
        image: {
          src: '/jpg/car_01.jpg',
          alt: 'Car rental'
        }
      },
      {
        icon: 'bi-house-door-fill',
        image: {
          src: '/jpg/accommodation_01.jpg',
          alt: 'Accommodations'
        }
      },
      {
        icon: 'bi-bus-front-fill',
        image: {
          src: '/jpg/delivery_01.jpg',
          alt: 'Delivery to locations'
        }
      },
      {
        icon: 'bi-map-fill',
        image: {
          src: '/jpg/vyhled_01.jpg',
          alt: 'Places Guide'
        }
      }
    ]
    
    init_elm()
  end

  def connected_callback()
  end

  def disconnected_callback()
  end

  def init_elm()
    template = """
<h1 class='text-center'>#{@words[0]}</h1>
<p class='text-center'>#{@words[1]}</p>

#{subinit_elm()}
    """

    self.innerHTML = template
  end

  def subinit_elm()
    elements = []

    @words[2].each_with_index do |element, i|
      is_odd = (i+1) % 2 != 0
      detail_obj = @detail_elements[i]
      style = is_odd ? ['', ''] : ['order-md-2', 'order-md-1']

      template = """
<div class='row mt-5'>
  <div class='col-md-6 #{style[0]}'>
    <h2>#{element.name} <i class='bi #{detail_obj.icon}'></i></h2>
    <p>#{element.description}</p>
    <ul>
      #{list_init_elm(element.points)}
    </ul>

    <div class='price-box mt-3 mb-3 p-3 text-center rounded-3'>
      <h3 class='fw-bold mb-0'>#{element.price}</h3>
    </div>
  </div>
  <div class='col-md-6 #{style[1]}'>
    <elm-lazy-image src='#{detail_obj.image.src}' class='rounded' alt='#{detail_obj.image.alt}' style='border-radius:  0.375rem;'></elm-lazy-image>
  </div>
</div>
      """
      elements.push(template)
    end

    return elements.join('')
  end

  def list_init_elm(points)
    elements = []

    points.each do |point|
      template = "<li>#{point}</li>"
      elements.push(template)
    end

    return elements.join('')
  end
end