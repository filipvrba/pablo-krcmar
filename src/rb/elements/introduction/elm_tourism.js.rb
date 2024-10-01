export default class ElmIntroductionTourism < HTMLElement
  def initialize
    super
    
    @words = Language.relevant.introduction_tourism

    init_elm()
  end

  def connected_callback()
  end

  def disconnected_callback()
  end

  def init_elm()
    template = """
<div class='container my-5'>
  <h2 class='text-center'>#{@words[0]}</h2>
  <p class='text-center'>#{@words[1]}</p>

  <div class='row text-center mt-5'>
      <!-- Pláž -->
      <div class='col-md-4 mb-3'>
          <div class='card'>
              <img src='/jpg/plaz_01.jpg' class='card-img-top' loading='lazy' alt='Beach'>
              <div class='card-body'>
                  <h5 class='card-title'>#{@words[2]}</h5>
                  <p class='card-text'>#{@words[3]}</p>
              </div>
          </div>
      </div>
      <!-- Jezero -->
      <div class='col-md-4 mb-3'>
          <div class='card'>
              <img src='/jpg/jezero_01.jpg' class='card-img-top' loading='lazy' alt='Lake'>
              <div class='card-body'>
                  <h5 class='card-title'>#{@words[4]}</h5>
                  <p class='card-text'>#{@words[5]}</p>
              </div>
          </div>
      </div>
      <!-- Moře a výhledy -->
      <div class='col-md-4 mb-3'>
          <div class='card'>
              <img src='/jpg/vyhled_01.jpg' class='card-img-top' loading='lazy' alt='Sea'>
              <div class='card-body'>
                  <h5 class='card-title'>#{@words[6]}</h5>
                  <p class='card-text'>#{@words[7]}</p>
              </div>
          </div>
      </div>
  </div>
</div>
    """

    self.innerHTML = template
  end
end