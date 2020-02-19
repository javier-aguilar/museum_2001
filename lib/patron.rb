class Patron

  attr_reader :name, :spending_money, :interests

  def initialize(name_param, money_param)
    @name = name_param
    @spending_money = money_param
    @interests = []
  end

  def add_interest(interest)
    @interests << interest
  end

end
