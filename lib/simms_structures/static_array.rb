# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length, nil)
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  private

  def check_index(idx)
    raise TypeError 'Invalid Position' if 0 > idx || idx > @store.length
  end

  protected
  attr_accessor :store
end
