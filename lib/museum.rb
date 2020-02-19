class Museum

  attr_reader :name, :exhibits, :patrons

  def initialize(name_param)
    @name = name_param
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommended = []
    patron.interests.each do | interest |
      @exhibits.each do | exhibit |
        recommended << exhibit if interest == exhibit.name
      end
    end
    recommended
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    patrons_by_exhibit = {}
    @exhibits.each do | exhibit |
      if !patrons_by_exhibit.key? exhibit
        patrons_by_exhibit[exhibit] = []
      end
    end
    @patrons.each do | patron |
      patron.interests.each do | interest |
        @exhibits.each do | exhibit |
          if interest == exhibit.name
            patrons_by_exhibit[exhibit] << patron
          end
        end
      end
    end
    patrons_by_exhibit
  end

end
