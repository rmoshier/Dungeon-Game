class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect { |room| room.reference == reference}
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
    if :location == :largecave && :direction == :east
      puts "Please go west."
    end

    if :location == :smallcave && :direction == :west
      puts "Please go east."
    end
    # add logic for what to do when response is nil.
    # what audrey would do: if no room to east. stay in same room
    # and give them other options
  end

  def go(direction)
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
    self.continue
  end

  def continue
    puts "Where else do you want to go?"
    input = gets.chomp.to_sym
    if input == :west || input == :east
      # input == :west || :east other way to do it in ruby,
      # but linder makes an angry yellow box, so i'm using
      # double input
      def room
        if room = :largecave && input == :east
          puts "You can only move west."
        end

        if room = :smallcave && input == :west
          puts "You can only move east."
        end
      #   # room connects to? :east => true
      #   # connects to?
      #   # find current room
      #   # ask if connects to current room
      #   # then conditional
      #   # else stuck message.
      end

      self.go(input)
      # add exit in else statement. check the input. abort.
    else
      puts "Congratulations you have toured the whole dungeon!"
      puts "Good bye!"
      abort
    end
  end

  #def snack #need to link this to correct place


  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name = name
    end
  end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\n\nYou are in " + @description
    end
  end

end

# Create the main dungeon object
my_dungeon = Dungeon.new("Rachel")

# Add rooms to dungeon
my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {:west => :smallcave})
my_dungeon.add_room(:smallcave, "Small Cave", "a small claustrophobic cave", {:east => :largecave})

# Start the dungeon by place the player in the large cave
my_dungeon.start(:largecave)
puts "Welcome to the dungeon. Where do you want to go?"
input = gets.chomp.to_sym
my_dungeon.go(input)
