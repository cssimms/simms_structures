require_relative 'heap2'
require 'byebug'

class PriorityMap
  def initialize(&prc)
    @queue = BinaryMinHeap.new(&prc)
    @map = {}
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    @queue.push(key)
    @map[key] = value
  end

  def count
    @map.count
  end

  def empty?
    @map.empty?
  end

  def extract
    top = @queue.extract
    cost = @map.delete(top)
    [top, cost]
  end

  def has_key?(key)
    @map[key] ? true : false
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    has_key?(key) ? update(key, value) : self[key] = value
  end

  def update(key, value)
    @queue.reduce!(key)
    @queue.push(key)
  end
end
