export default class ElmIntroduction < HTMLElement
  def initialize
    super
    
    @words = Language.relevant.introduction

    init_elm()
  end

  def connected_callback()
  end

  def disconnected_callback()
  end

  def init_elm()
    # <h1 class='text-center mt-5'>#{@words[0]}</h1>
    # <p class='text-center'>#{@words[1]}</p>

    template = """
<div class='row'>
  <div class='col-md-6 mb-4 ps-lg-5'>
    <h1>#{@words[0]}</h1>
    <p class='lead'>#{@words[1]}</p>
  </div>
  <div class='col-md-6 text-center d-flex justify-content-center my-auto'>
    <elm-lazy-image src='/jpg/avatar_02.jpg' class='max-400' classt='max-400' style='border-radius: 50%;' alt='Pablo Krcmar'></elm-lazy-image>
  </div>
</div>

<div class='row text-center mt-5'>
  <!-- Půjčení auta -->
  <div class='col-lg-3 col-md-6 mb-3'>
    <div class='card h-100'>
      <div class='card-body'>
        <i class='bi bi-car-front-fill' style='font-size: 3rem;'></i>
        <h5 class='card-title mt-3'>#{@words[2]}</h5>
        <p class='card-text'>#{@words[3]}</p>
      </div>
    </div>
  </div>
  <!-- Ubytování -->
  <div class='col-lg-3 col-md-6 mb-3'>
    <div class='card h-100'>
      <div class='card-body'>
        <i class='bi bi-house-door-fill' style='font-size: 3rem;'></i>
        <h5 class='card-title mt-3'>#{@words[4]}</h5>
        <p class='card-text'>#{@words[5]}</p>
      </div>
    </div>
  </div>
  <!-- Rozvoz po místech -->
  <div class='col-lg-3 col-md-6 mb-3'>
    <div class='card h-100'>
      <div class='card-body'>
        <i class='bi bi-bus-front-fill' style='font-size: 3rem;'></i>
        <h5 class='card-title mt-3'>#{@words[6]}</h5>
        <p class='card-text'>#{@words[7]}</p>
      </div>
    </div>
  </div>
  <!-- Průvodce místy -->
  <div class='col-lg-3 col-md-6 mb-3'>
    <div class='card h-100'>
      <div class='card-body'>
        <i class='bi bi-map-fill' style='font-size: 3rem;'></i>
        <h5 class='card-title mt-3'>#{@words[8]}</h5>
        <p class='card-text'>#{@words[9]}</p>
      </div>
    </div>
  </div>
</div>
    """

    self.innerHTML = template
  end
end