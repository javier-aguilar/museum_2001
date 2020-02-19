require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'
require 'mocha/minitest'

class MuseumTest < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")

    @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    @imax = Exhibit.new({name: "@imax",cost: 15})

  end

  def test_it_exists
    @dmns = Museum.new("Denver Museum of Nature and Science")
    assert_instance_of Museum, @dmns
  end


  def test_it_has_attributes
    @dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_it_can_add_exhibits
    @dmns = Museum.new("Denver Museum of Nature and Science")

    @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    @imax = Exhibit.new({name: "@imax",cost: 15})

    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    expected = [@gems_and_minerals, @dead_sea_scrolls, @imax]

    assert_equal expected, @dmns.exhibits
  end

  def test_it_can_recommend_exhibits
    @dmns = Museum.new("Denver Museum of Nature and Science")

    @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    @imax = Exhibit.new({name: "@imax",cost: 15})

    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    patron1 = Patron.new("Bob", 20)
    patron1.add_interest("Dead Sea Scrolls")
    patron1.add_interest("Gems and Minerals")

    patron2 = Patron.new("Sally", 20)
    patron2.add_interest("@imax")

    assert_equal [@dead_sea_scrolls, @gems_and_minerals],@dmns.recommend_exhibits(patron1)
    assert_equal [@imax],@dmns.recommend_exhibits(patron2)
  end

  def test_it_can_show_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [], @dmns.patrons

    patron1 = Patron.new("Bob", 0)
    patron1.add_interest("Gems and Minerals")
    patron1.add_interest("Dead Sea Scrolls")

    patron2 = Patron.new("Sally", 20)
    patron2.add_interest("Dead Sea Scrolls")

    patron3 = Patron.new("Johnny", 5)
    patron3.add_interest("Dead Sea Scrolls")

    @dmns.admit(patron1)
    @dmns.admit(patron2)
    @dmns.admit(patron3)

    assert_equal [patron1, patron2, patron3], @dmns.patrons

    expected = {
      @gems_and_minerals => [patron1],
      @dead_sea_scrolls => [patron1, patron2, patron3],
      @imax => []
    }

    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end

  def test_it_can_show_ticket_lottery_contestants
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [], @dmns.patrons

    patron1 = Patron.new("Bob", 0)
    patron1.add_interest("Gems and Minerals")
    patron1.add_interest("Dead Sea Scrolls")

    patron2 = Patron.new("Sally", 20)
    patron2.add_interest("Dead Sea Scrolls")

    patron3 = Patron.new("Johnny", 5)
    patron3.add_interest("Dead Sea Scrolls")

    @dmns.admit(patron1)
    @dmns.admit(patron2)
    @dmns.admit(patron3)

    assert_equal [patron1, patron3], @dmns.ticket_lottery_contestants(@dead_sea_scrolls)
    assert_equal [], @dmns.ticket_lottery_contestants(@imax)
  end

  def test_it_can_announce_lottery_winner
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    patron1 = Patron.new("Bob", 0)
    patron1.add_interest("Gems and Minerals")
    patron1.add_interest("Dead Sea Scrolls")

    patron2 = Patron.new("Sally", 20)
    patron2.add_interest("Dead Sea Scrolls")

    patron3 = Patron.new("Johnny", 5)
    patron3.add_interest("Dead Sea Scrolls")

    @dmns.admit(patron1)
    @dmns.admit(patron2)
    @dmns.admit(patron3)

    @dmns.stubs(:draw_lottery_winner).returns(patron1)

    assert_equal patron1, @dmns.draw_lottery_winner(@dead_sea_scrolls)
  end

end
