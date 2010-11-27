$LOAD_PATH << '../lib'

require 'locative_agent.rb'

describe LocativeAgent do
  #Test the Locative functionality
  it "should correctly recognize points that exist within it" do
    la = LocativeAgent.new(2,2,2,2)
    la.should be_point_within_bounds(3, 3)
  end
  
  it "should correctly recognize points that do NOT exist within it" do
    la = LocativeAgent.new(2,2,2,2)
    la.should_not be_point_within_bounds(6,6)
    la.should_not be_point_within_bounds(4,4)
  end
  
  it "should correctly recognize collisions with other locatives" do
    la1 = LocativeAgent.new(2,2,2,2)
    la2 = LocativeAgent.new(3,3,1,1)
    la1.should be_colliding(la2)

    #full containment
    la1 = LocativeAgent.new(0,0,10,10)
    la1.should be_colliding(la2)

  end
  
  it "should correctly recognize NON collisions with other locatives" do
    la1 = LocativeAgent.new(2,2,2,2)
    la2 = LocativeAgent.new(4,4,1,1)
    la1.should_not be_colliding(la2)
  end
  
end