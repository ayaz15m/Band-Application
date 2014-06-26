#Ayaz Merchant
#
#Week 1 Project
#================================
# A promoter has asked you to create a concert application for them.
# You'll have a Ruby application where you can:
#
# Display to the user a list of opening-acts that they can choose from
# Let the user choose 2 of the opening-acts
# Let the user enter information for a new headline-act
# Let the user press "Play" and output the acts in order

require "active_support/all"

class Band

  attr_accessor :name, :time

  def initialize(name, time)
    @name = name
    @time = time
  end
end

class Concert

  def select_concert
    puts "How many opening acts would like to choose from (2-20)?"

    is_set_correctly = false

    answer = ""

    until (is_set_correctly)
      answer = gets.chomp.to_i

      if answer.between?(2,20)
        is_set_correctly = true
      else
        puts "Please choose a valid number of bands to pick from (2-20)."
      end
    end

    bands = []

    answer.times do
      band_name = [*("A".."Z")].sample(5).join

      band_time = [*(10..99)].sample(1).join

      random_band = Band.new band_name, band_time

      bands << random_band
    end

    puts
    puts "Here is the list of opening acts you can choose from:"

    counter = 0

    until counter == answer
      output = bands.map do |band|
      counter += 1
      puts "#{counter}. Band #{band.name} is playing for #{band.time} minutes."
      end
    end

    pick_bands(bands, answer)
  end

  def pick_bands(bands,answer)
    puts
    puts "You can choose two bands to be the opening acts of your concert."

    puts "Please choose the number of the first band."
    check_opening_acts(answer)
    @user_band1 = @answer-1

    puts "Please choose the number of the second band."
    check_opening_acts(answer)
    @user_band2 = @answer-1

    check_band_selection(answer)

    user_headliner = headliner

    arrange_bands(bands, user_headliner)
  end

  def check_opening_acts(answer)
    is_set_correctly = false

    until (is_set_correctly)
      @answer = gets.chomp.to_i

      if @answer.between?(1,answer)
        is_set_correctly = true
        return @answer
      else
        puts "Please enter a band from the list above (1-#{answer})."
      end
    end
  end

  def check_band_selection(answer)
    is_set_correctly = false

    until (is_set_correctly)
      if @user_band1 == @user_band2
        puts "Please choose a different second band"
        check_opening_acts(answer)
        @user_band2 = @answer-1
      else
        is_set_correctly = true
      end
    end
  end

  def headliner
    puts
    puts "Next you can enter the information of the headline act"

    puts "Please enter the name of the band."
    user_name = check_headliner_band

    puts "Please enter the length of the headline performance in minutes."
    user_time = check_headliner_time

    user_band = Band.new user_name, user_time
    return user_band
  end

  def check_headliner_band
    name = gets.chomp.upcase[/^[a-zA-Z0-9 ]*$/]
    user_name = check_response(name)

    is_set_correctly = false

    until (is_set_correctly)
      puts "The band's name you have entered is #{user_name}, is this correct(y/n)?"
      answer = gets.chomp.downcase

      if answer == "y"
        is_set_correctly = true
        return user_name
      elsif answer == "n"
        puts "Please enter the name of the band."
        name = gets.chomp.upcase[/^[a-zA-Z0-9 ]*$/]
        user_name = check_response(name)
      else
        puts "Please enter a valid response."
      end
    end
  end

  def check_response(name)
    set_correctly = false

    until set_correctly == true
      if name.blank?
        puts "Please enter a valid band name (a-z,0-9)"
        name = gets.chomp.upcase[/^[a-zA-Z0-9 ]*$/]
      else
        set_correctly = true
        return name
      end
    end
  end

  def check_headliner_time
    @user_time = gets.chomp.strip
    is_set_correctly = false

    until (is_set_correctly)
      if @user_time.to_i <= 0
        puts "Please enter a numerical value greater than 0 minutes for the length of the performance."
        @user_time = gets.chomp.strip
      else
        is_set_correctly = true
        return @user_time
      end
    end
  end

  def arrange_bands(bands, user_headliner)
    if bands[@user_band1].time < bands[@user_band2].time
      first_band = @user_band1
      second_band = @user_band2
    else
      first_band = @user_band2
      second_band = @user_band1
    end

    concert = []
    concert << bands[first_band]
    concert << bands[second_band]
    concert << user_headliner

    print_concert(concert)
  end

  def print_concert(concert)
    puts
    puts "Here is a list of the concert you have selected:"

    counter = 1

    output = concert.map do |band|
    puts "#{counter}. Band #{band.name} will perform for #{band.time} minutes."
    counter += 1
    end
  end
end

puts
puts "Welcome!"
puts "Use this application to customize a concert with 2 opening acts and your headline act."
puts

Concert.new.select_concert

is_set_correctly = false
until (is_set_correctly)
  puts
  puts "Would you like to create another concert application(y/n)?"
  answer = gets.chomp.downcase
  if answer == "y"
    Concert.new.select_concert
  elsif answer == "n"
    puts
    puts "Thank You!"
    is_set_correctly = true
    break
  else
    puts "Please enter a valid response."
  end
end
