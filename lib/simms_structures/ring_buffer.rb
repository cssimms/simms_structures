require_relative 'static_array'
require_relative 'dynamic_array'

class RingBuffer
  attr_reader :length

  def initialize(size = 8)
    @store = StaticArray.new(size)
    @start_idx = 0
    @length = 0
    @capacity = size
  end

  def relative_index(index)
    (@start_idx + index) % @capacity
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[relative_index(index)]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[relative_index(index)] = value
  end

  # O(1)
  def pop
    check_index(0)
    @length -= 1
    @store[(@start_idx + @length) % @capacity]
  end

  # O(1) ammortized
  def push(value)
    resize! if @length == @capacity
    @store[(@start_idx + @length) % @capacity] = value
    @length += 1
    nil
    # debugger
  end

  # O(1)
  def shift
    check_index(0)
    value = self[0]
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    value
  end

  # O(1) ammortized
  def unshift(value)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = value
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)
    @length.times { |idx| new_store[idx] = @store[relative_index(idx)]}

    @store = new_store
    @capacity = new_capacity
    @start_idx = 0
  end
end
