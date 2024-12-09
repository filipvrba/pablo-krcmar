export default class ElmServices < HTMLElement
  COROUSEL_INTERVAL = 10.0

  def initialize
    super

    @h_tick = lambda {|e| corousel_update(e.detail.value) }

    @words = Language.relevant.services
    @detail_elements = [
      {
        icon: 'bi-car-front-fill',
        image: {
          src: ['/jpg/car_02.jpg'],
          alt: 'Car rental'
        }
      },
      {
        icon: 'bi-house-door-fill',
        image: {
          src: ['/jpg/accommodation_02.jpg'],
          alt: 'Accommodations'
        }
      },
      {
        icon: 'bi-bus-front-fill',
        image: {
          src: ['/jpg/delivery_01.jpg'],
          alt: 'Delivery to locations'
        }
      },
      {
        icon: 'bi-map-fill',
        image: {
          src: ['/jpg/vyhled_01.jpg'],
          alt: 'Places Guide'
        }
      }
    ]
    
    init_elm()

    @corousels = self.query_selector_all('.carousel')
    @corousel_time = 0
  end

  def connected_callback()
    Events.connect('#app', 'tick', @h_tick)
  end

  def disconnected_callback()
    Events.disconnect('#app', 'tick', @h_tick)
  end

  def corousel_update(dt)
    @corousel_time += dt

    if @corousel_time >= COROUSEL_INTERVAL
      @corousel_time = 0
      @corousels.each do |corousel|
        btn_next = corousel.query_selector('.carousel-control-next')
  
        btn_next.click()
      end
    end
  end

  def init_elm()
    template = """
<h1 class='text-center'>#{@words[0]}</h1>
<p class='text-center'>#{@words[1]}</p>

#{subinit_elm()}
    """

    self.innerHTML = template
  end

  def imgs_init_elm(detail_obj)
    l_lazy_image = lambda do |src|
      return "<elm-lazy-image src='#{src}' class='rounded' alt='#{detail_obj.image.alt}' style='border-radius:  0.375rem;'></elm-lazy-image>"
    end

    unless detail_obj.image.src.length > 1
      return l_lazy_image(detail_obj.image.src[0])
    end

    elements = []

    detail_obj.image.src.each_with_index do |src, i|
      active_style = i == 0 ? 'active' : ''
      template = """
      <div class='carousel-item #{active_style}'>
        <elm-lazy-image src='#{src}' class='rounded' alt='#{detail_obj.image.alt}' style='border-radius:  0.375rem;'></elm-lazy-image>
      </div>
      """
      elements.push(template)
    end

    template_carousel = """
    <div id='carouselTemplate' class='carousel slide'>
      <div class='carousel-inner'>
        #{elements.join('')}
      </div>
      <button class='carousel-control-prev' type='button' data-bs-target='#carouselTemplate' data-bs-slide='prev'>
        <span class='carousel-control-prev-icon' aria-hidden='true'></span>
        <span class='visually-hidden'>Previous</span>
      </button>
      <button class='carousel-control-next' type='button' data-bs-target='#carouselTemplate' data-bs-slide='next'>
        <span class='carousel-control-next-icon' aria-hidden='true'></span>
        <span class='visually-hidden'>Next</span>
      </button>
    </div>
    """

    return template_carousel
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
    #{imgs_init_elm(detail_obj)}
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