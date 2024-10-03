import 'csObj', '../../json/languages/cs.json'
import 'enObj', '../../json/languages/en.json'
import 'esObj', '../../json/languages/es.json'

export default class Language
  ENVS = {
    language_change: 'lang0'
  }

  def self.relevant
    code_lang = Language.get || navigator.language.split('-').first

    case code_lang
    when :cs
      return cs_obj
    when :en
      return en_obj
    when :es
      return es_obj
    else
      return cs_obj
    end
  end

  def self.get
    local_storage.get_item('lang') || URLParams.get('lang')
  end

  def self.set(code_lang)
    URLParams.set("lang", code_lang)
    local_storage.set_item('lang', code_lang)

    Events.emit('#app', ENVS.language_change)
  end
end
window.Language = Language
