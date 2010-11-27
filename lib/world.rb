require 'set'
require 'patch'
require 'circler'

GRID_SIZE = 32
PATCH_SIZE = 1

class World
  def initialize
    @patches = Array.new(GRID_SIZE) { Array.new(GRID_SIZE) }
    @turtles = Set.new
    
    GRID_SIZE.times do |row|
      GRID_SIZE.times do |col|
        @patches[row][col] = Patch.new(row * PATCH_SIZE, col * PATCH_SIZE, PATCH_SIZE, PATCH_SIZE, self)
      end
    end    
  end

  def turtle_created(turtle)
    @turtles << turtle
  end
  
  def turtle_destroyed(turtle)
    @turtles.delete(turtle)
  end
  
  def patch_for_coordinate(x, y)
    x_index = (x / PATCH_SIZE).floor
    y_index = (y / PATCH_SIZE).floor
    return @patches[x_index][y_index]
  end

  def setup
    x = 10
    y = 10
    patch = patch_for_coordinate(x, y)
    turtle = Circler.new(x,y,patch,self)
  end
  
  def tick
    @patches.flatten.shuffle.each do |patch|
      patch.tick
    end
    
    @turtles.to_a.shuffle.each do |turtle|
      turtle.tick
    end
  end
  
  def dump
    ret = {}
    
    turtles = []
    @turtles.each do |turtle|
      turtles << turtle.dump
    end
    
    patches = []
    @patches.flatten.each do |patch|
      patches << patch.dump
    end
    
    ret[:turtles] = turtles
    ret[:patches] = patches
    
    return ret
  end
  
  def dump_dirty
    ret = {}
    
    turtles = []
    @turtles.each do |turtle|
      if turtle.dirty
        turtles << turtle.dump
        turtle.dirty = false
      end
    end
    
    patches = []
    @patches.flatten.each do |patch|
      if patch.dirty
        patches << patch.dump
        patch.dirty = false
      end
    end
    
    ret[:turtles] = turtles
    ret[:patches] = patches
    
    return ret
  end
  
  def run
    puts "Running!"
    setup
    4.times do |t|
      tick
    end
    
    puts dump.inspect 
    tick
    puts dump_dirty.inspect
    tick
    puts dump_dirty.inspect
  end  
end

