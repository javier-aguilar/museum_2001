class Exhibit

  attr_reader :name, :cost

  def initialize(info_params)
    @name = info_params[:name]
    @cost = info_params[:cost]
  end

end
