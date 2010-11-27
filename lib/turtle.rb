require 'patch'

DEFAULT_TURTLE_SIZE = 1

class Turtle<LocativeAgent
  def initialize(x, y, patch, world)
    super(x, y, DEFAULT_TURTLE_SIZE, DEFAULT_TURTLE_SIZE)
    @patch = patch
    @world = world
    @heading = 0
    @world.turtle_created self
    @patch.turtle_entered self
    
    @dumpables << :heading
  end
  
  def turn_right(degrees)
    @heading += degrees
    @dirty = true
  end
  
  def turn_left(degrees)
    turn_right(0-degrees)
  end
  
  def move_forward(meters)
    @y += meters * Math.sin(@heading/180.0 * Math::PI)
    @x += meters * Math.cos(@heading/180.0 * Math::PI)
    
    if !@patch.point_within_bounds?(@x,@y)
      @patch.turtle_left self
      @patch = @world.patch_for_coordinate @x, @y
      @patch.turtle_entered self
    end
    @dirty = true
  end
  
  def move_backward(meters)
    move_forward(0-meters)
  end
  
  def on_die
  end
  
  def die!
    on_die
    @patch.turtle_left self
    @world.turtle_destroyed self
  end
  
  def turtles_within_radius(radius)
    ret = @patch.turtles_within_radius(radius)
    ret.delete(self)
    return ret
  end  
end