require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(size = 8)
    @store = StaticArray.new(size)
    @length = 0
    @capacity = size
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= (@length)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    value = self[@length - 1]
    @length -= 1
    value
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(value)
    resize! if @length == @capacity
    self[@length] = value
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    1.upto(@length - 1) do |idx|
      self[idx - 1] = self[idx]
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(value)
    resize! if @length == @capacity

    (@length - 1).downto(0) do |idx|
      self[idx + 1] = self[idx]
    end if @length > 0
    self[0] = value
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)

  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)
    @length.times { |idx| new_store[idx] = self[idx] }
    @store = new_store
    @capacity = new_capacity
  end
end
