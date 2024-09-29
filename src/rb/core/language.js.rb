import 'csObj', '../../json/languages/cs.json'
import 'enObj', '../../json/languages/en.json'
import 'esObj', '../../json/languages/es.json'

export default class Language
  def self.relevant
    code_lang = navigator.language.split('-').first

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
end
window.Language = Language
