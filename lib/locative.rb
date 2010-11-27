require 'set'
require 'dumpable'

module Locative
  include Dumpable

  attr_accessor :x,:y,:width,:height
    
  def initialize_location(x,y,width,height)
    @x = x
    @y = y
    @width = width
    @height = height
    
    @dumpables.merge [:x, :y, :width, :height]
    
  end
      
  def point_within_bounds?(x,y)
    return (@x <= x) && (x < (@x + @width)) && (@y <= y) && (y < (@y + @height))
  end


  def colliding?(other_locative)
    return (@x + @width) > other_locative.x &&
            @x < (other_locative.x + other_locative.width) &&
           (@y + @height) > other_locative.y &&
            @y < (other_locative.y + other_locative.height)
  end

end