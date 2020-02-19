class Museum

  attr_reader :name, :exhibits

  def initialize(name_param)
    @name = name_param
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

end
