class Museum

  attr_reader :name, :exhibits, :patrons, :patrons_of_exhibits

  def initialize(name_param)
    @name = name_param
    @exhibits = []
    @patrons = []
    @patrons_of_exhibits = {}
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommended = []
    patron.interests.each do | interest |
      @exhibits.each do | exhibit |
        recommended << exhibit if interest == exhibit.name
      end
    end
    recommended
  end

  def admit(patron)
    exhibits = recommend_exhibits(patron)
    exhibits.each do | exhibit |
      if patron.spending_money >= exhibit.cost
        if !@patrons_of_exhibits.key? exhibit
          @patrons_of_exhibits[exhibit] = [patron]
        else
          @patrons_of_exhibits[exhibit] << patron
        end
      end
    end
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    #there is probably an easier way...
    patrons_by_exhibit = {}
    @exhibits.each do | exhibit |
      if !patrons_by_exhibit.key? exhibit
        patrons_by_exhibit[exhibit] = []
      end
    end
    @patrons.each do | patron |
      patron.interests.each do | interest |
        @exhibits.each do | exhibit |
          if interest == exhibit.name
            patrons_by_exhibit[exhibit] << patron
          end
        end
      end
    end
    patrons_by_exhibit
  end

  def ticket_lottery_contestants(exhibit_param)
    lottery_users = []
    patrons_by_exhibit_interest.each do | exhibit, patrons|
      patrons.each do | patron |
        if (patron.interests.include? exhibit_param.name)
          if patron.spending_money < exhibit.cost
            lottery_users << patron
          end
        end
      end
    end
    # && (!lottery_users.include? patron)
    lottery_users
  end

  def draw_lottery_winner(exhibit_param)
    winner = ticket_lottery_contestants(exhibit_param).sample
    winner
  end

end
