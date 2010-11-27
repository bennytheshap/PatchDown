require 'rubygems'
require 'uuid'

module Dumpable  
  attr_accessor :dirty
  
  def initialize
    @dumpables = Set.new
    @uuid = UUID.new.generate
    @dumpables << :uuid
  end
  
  def dump
    ret = {}
    @dumpables.each do |var_name|
      ret[var_name] = instance_variable_get("@#{var_name}")
    end
    return ret
  end
end