require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @store = Array.new
  end

  def count
    @store.length
  end

  def peek
    @store.last
  end

  def extract

  end

# change name to insert later
  def push(val)

  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_idx)
    first_child_idx = ( parent_idx * 2 ) + 1
    second_child_idx = ( parent_idx * 2 ) + 2

    [first_child_idx, second_child_idx].select do |idx|
      idx < len && idx > -1
    end
  end

  def self.parent_index(child_idx)
    raise 'root has no parent' if child_idx == 0
    ( child_idx - 1 ) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return if child_idx == 0
    prc = Proc.new { |a, b| a <=> b } unless prc

    parent_idx = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[parent_idx], array[child_idx]) > -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
    end
    array
  end
end
