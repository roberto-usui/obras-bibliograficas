class BibliographyList
  SECONDARY_LASTNAME_REGEX = /^((FILH(A|O))|(NET(O|A))|(SOBRINH(O|A))|(JUNIOR))$/
  PREPOSITION_REGEX = /^((D(E|(A|AS)|(O|OS))))$/

  def initialize(fullnames)
    @fullnames = fullnames
  end

  def format_fullnames
    if @fullnames.nil? || @fullnames.empty?
      return []
    end
    return @fullnames.map{|name| format_fullname(name)}
  end

  private

  def format_fullname(fullname)
    result = ""
    names = fullname.split(' ')
    if names.size == 1
      return names.first.upcase
    end

    if names.last.upcase =~ SECONDARY_LASTNAME_REGEX && names.size > 2
      lastname = names.delete_at(-2)
      result << "#{treat_preposition_lastname(lastname)} #{names.delete_at(-1).upcase},"
    else
      result << "#{treat_preposition_lastname(names.delete_at(-1))},"
    end

    for name in names
      result << " #{treat_preposition_name(name)}"
    end

    return result
  end

  def treat_preposition_lastname(name)
    return name.upcase =~ PREPOSITION_REGEX ? name.downcase : name.upcase
  end

  def treat_preposition_name(name)
    return name.upcase =~ PREPOSITION_REGEX ? name.downcase : name.capitalize
  end
end
