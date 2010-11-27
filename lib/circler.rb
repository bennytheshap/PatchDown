require 'turtle'

class Circler < Turtle
  def tick
    super
    move_forward 4
    turn_right 90
  end
end