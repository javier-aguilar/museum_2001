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

    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end


  def test_it_has_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
  end

  def test_it_can_add_exhibits
    expected = [@gems_and_minerals, @dead_sea_scrolls, @imax]

    assert_equal expected, @dmns.exhibits
  end

  def test_it_can_recommend_exhibits
    patron1 = Patron.new("Bob", 20)
    patron1.add_interest("Dead Sea Scrolls")
    patron1.add_interest("Gems and Minerals")

    patron2 = Patron.new("Sally", 20)
    patron2.add_interest("@imax")

    assert_equal [@dead_sea_scrolls, @gems_and_minerals],@dmns.recommend_exhibits(patron1)
    assert_equal [@imax],@dmns.recommend_exhibits(patron2)
  end

  def test_it_can_show_patrons_by_exhibit_interest
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

  def test_admit_based_on_spending_money
    tj = Patron.new("TJ", 7)
    tj.add_interest("IMAX")
    tj.add_interest("Dead Sea Scrolls")
    @dmns.admit(tj)
    tj.spending_money

    expected = {}
    assert_equal expected, @dmns.patrons_of_exhibits


    patron1 = Patron.new("Bob", 10)
    patron1.add_interest("Dead Sea Scrolls")
    patron1.add_interest("IMAX")
    @dmns.admit(patron1)
    patron1.spending_money

    expected2 = {
      @dead_sea_scrolls => [patron1]
    }

    assert_equal expected2, @dmns.patrons_of_exhibits

    patron2 = Patron.new("Sally", 20)
    patron2.add_interest("IMAX")
    patron2.add_interest("Dead Sea Scrolls")
    @dmns.admit(patron2)
    patron2.spending_money

    expected3 = {
      @dead_sea_scrolls => [patron1],
      @imax => [patron2]
    }

    assert_equal expected3, @dmns.patrons_of_exhibits
  end

end
