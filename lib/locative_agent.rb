require 'agent'
require 'locative'

class LocativeAgent < Agent
  include Locative
  
  def initialize(x,y,width,height)
    super()
    initialize_location x, y, width, height
  end
end