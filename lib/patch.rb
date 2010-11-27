require 'set'
require 'locative_agent'

class Patch < LocativeAgent
  attr_reader :turtles
  
  def initialize(x, y, width, height, world)
    super(x,y,width,height)
    @world = world
    @turtles = Set.new
  end
  
  def turtle_entered(turtle)
    #puts "Turtle entered patch at #{@x}, #{@y}"
    @turtles.add(turtle)
    @dirty = true
  end
  
  def turtle_left(turtle)
    #puts "Turtle left patch at #{@x}, #{@y}"
    @turtles.delete(turtle)
    @dirty = true
  end
  
  def turtles_within_radius(radius)
    if radius > (@width/2) || radius > (@height/2)
      patches_away_x = (radius / width).floor
      patches_away_y = (radius / height).floor
      turtles = Set.new
      (-patches_away_x..patches_away_x).each do |p_x|
        (-patches_away_y..patches_away_y).each do |p_y|
          turtles.merge @world.patch_for_coordinate(@x + p_x*@width, @y + p_y*@height).turtles.to_a
        end
      end
      #puts turtles.to_a.map {|t| t.object_id}
      return turtles.to_a.shuffle
    else
      return @turtles.to_a.shuffle
    end
  end

  def tick
    super
    #do own tick stuff
  end
end  