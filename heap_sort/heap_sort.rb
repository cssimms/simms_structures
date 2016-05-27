require_relative "heap"
require 'byebug'


class Array
  def heap_sort!

    0.upto(length - 1) do |idx|
      BinaryMinHeap.heapify_up(self, idx)
    end

    (length - 1).downto(1) do |idx|
      self[0], self[idx] = self[idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, idx )
    end

    reverse!
  end
end
