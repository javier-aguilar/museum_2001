class Museum

  attr_reader :name, :exhibits

  def initialize(name_param)
    @name = name_param
    @exhibits = []
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

end
