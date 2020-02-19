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
    skip
  end

end
