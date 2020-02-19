class Museum

  attr_reader :name, :exhibits

  def initialize(name_param)
    @name = name_param
    @exhibits = []
  end

end
