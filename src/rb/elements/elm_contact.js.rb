import "contactObj", "../../json/contact.json"

export default class ElmContact < HTMLElement
  def initialize
    super
    
    @words = Language.relevant.contact

    init_elm()
  end

  def connected_callback()
  end

  def disconnected_callback()
  end

  def init_elm()
    tel_simple = contact_obj.telephone_number.gsub(/[ -]/, '')

    template = """
<h1 class='text-center'>#{@words[0]}</h1>
<p class='text-center'>#{@words[1]}</p>

<div class='row mt-5 justify-content-center'>
  <!-- Telefonní karta -->
  <div class='col-md-4'>
    <div class='card contact-card mb-4'>
      <div class='card-body text-center'>
        <i class='bi bi-telephone-fill' style='font-size: 2rem;'></i>
        <h5 class='card-title'>#{@words[2]}</h5>
        <p class='card-text'>
          <a href='tel:#{tel_simple}'>#{contact_obj.telephone_number}</a>
        </p>
      </div>
    </div>
  </div>

  <!-- E-mailová karta -->
  <div class='col-md-4'>
    <div class='card contact-card mb-4'>
      <div class='card-body text-center'>
        <i class='bi bi-envelope-fill' style='font-size: 2rem;'></i>
        <h5 class='card-title'>#{@words[3]}</h5>
        <p class='card-text'>
          <a href='mailto:#{contact_obj.email}'>#{contact_obj.email}</a>
        </p>
      </div>
    </div>
  </div>
</div>
    """

    self.innerHTML = template
  end
end