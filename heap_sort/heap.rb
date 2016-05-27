class BinaryMinHeap
  def initialize(&prc)
    @prc = prc
    @store = Array.new
  end

  def count
    @store.length
  end

  def peek
    @store.last
  end

  def extract
    last = @store.length - 1
    @store[0], @store[last] = @store[last], @store[0]
    output = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    output
  end

# change name to insert later
  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length - 1)
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
    prc ||= Proc.new { |a, b| a <=> b }

    child_idxs = BinaryMinHeap.child_indices(len, parent_idx)
    if child_idxs.empty?
      return array
    elsif child_idxs.count == 1
      target_child = child_idxs.first
    else
      if prc.call(array[child_idxs.first], array[child_idxs.last]) > -1
        target_child = child_idxs.last
      else
        target_child = child_idxs.first
      end
    end

    if prc.call(array[parent_idx], array[target_child]) > -1
      array[parent_idx], array[target_child] = array[target_child], array[parent_idx]
      BinaryMinHeap.heapify_down(array, target_child, len, &prc)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return if child_idx == 0
    prc ||= Proc.new { |a, b| a <=> b }

    parent_idx = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[parent_idx], array[child_idx]) > -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
    end
    array
  end
end
