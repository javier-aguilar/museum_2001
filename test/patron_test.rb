require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'

class PatronTest < Minitest::Test

  def test_it_exists
    patron1 = Patron.new("Bob", 20)
    assert_instance_of Patron, patron1
  end


  def test_it_has_attributes
    patron1 = Patron.new("Bob", 20)
    assert_equal "Bob", patron1.name
    assert_equal 20, patron1.spending_money
  end

  def test_it_can_add_interests
    skip
    patron1 = Patron.new("Bob", 20)
    assert_equal [], patron1.interests

    patron1.add_interest("Dead Sea Scrolls")
    patron1.add_interest("Gems and Minerals")
    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], patron1.interests
  end

end
