require 'set'
require 'locative_agent'

class Patch < LocativeAgent
  def initialize(x,y,width,height, world)
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

  def tick
    super
    #do own tick stuff
  end
end  