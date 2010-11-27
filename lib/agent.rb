class Agent
  def initialize
    if !defined(@dumpables)
      @dumpables = Set.new
    end    
  end
  
  def tick
  end
end