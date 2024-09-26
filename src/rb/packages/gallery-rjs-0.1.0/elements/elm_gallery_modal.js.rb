export default class ElmGalleryModal < HTMLElement
  def initialize
    super
    @l_gallery_click = lambda { |t| reinit_elm(t.detail.value) }
    @l_popstate = lambda { |e| popstate(e) }
    
    init_elm()
  end

  def connected_callback()
    Events.connect('#app', ENVS::GALLERY_CLICK, @l_gallery_click)
    window.add_event_listener('popstate', @l_popstate)
  end

  def disconnected_callback()
    Events.disconnect('#app', ENVS::GALLERY_CLICK, @l_gallery_click)
    window.remove_event_listener('popstate', @l_popstate)
  end

  def popstate(event)
    Events.emit('#galleryModal', 'modal.hide')
  end

  def init_elm()
    template = """
<div class='modal fade' id='galleryModal' tabindex='-1' role='dialog' aria-labelledby='galleryModalTitle' aria-hidden='true'>
  <div class='modal-dialog modal-lg modal-dialog-centered' role='document'>
    <div class='modal-content'>
      <div class='modal-header border-bottom-0'>
        <h1 id='modal-title' class='modal-title fs-5'></h1>
        <button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>
      </div>
      <div class='modal-body'>        
        <img src='' id='modal-image' class='img-fluid'>
        <button class='carousel-control-prev' type='button' onclick='modalBtnPrevClick()'>
          <span class='carousel-control-prev-icon' aria-hidden='true'></span>
        </button>
        <button class='carousel-control-next' type='button' onclick='modalBtnNextClick()'>
          <span class='carousel-control-next-icon' aria-hidden='true'></span>
        </button>
      </div>
    </div>
  </div>
</div>
    """

    self.innerHTML = template
  end

  def reinit_elm(card)
    document.get_element_by_id("modal-image").src       = card.picture
    document.get_element_by_id("modal-title").innerText = card.name
  end
end