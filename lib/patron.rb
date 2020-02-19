class Patron

  attr_reader :name, :spending_money

  def initialize(name_param, money_param)
    @name = name_param
    @spending_money = money_param
  end

end
