require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'

class ExhibitTest < Minitest::Test

  def test_it_exists
    exhibit = exhibit = Exhibit.new({name: "Gems and Minerals", cost: 0})
    assert_instance_of Exhibit, exhibit
  end


  def test_it_has_attributes

  end
end
