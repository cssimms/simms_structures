require 'byebug'
class QuickSort
  # Quick sort has average time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array.first

    left = []
    right = []

    array.drop(1).each do |el|
      if el < pivot
        left << el
      elsif el > pivot
        right << el
      end
    end

    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new { |a, b| a <=> b }

    pivot_idx = QuickSort.partition(array, start, length, &prc)

    left_length = pivot_idx - start
    right_length = length - (left_length + 1)

    sort2!(array, start, left_length, &prc)
    sort2!(array, pivot_idx + 1, right_length, &prc)
    array
  end

  def self.partition(array, start, length = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    first_right_idx = nil
    (start + 1).upto(start + length - 1) do |idx|
      case prc.call(array[start], array[idx])
      when -1
        first_right_idx ||= idx
      when 1
        if first_right_idx
          array[first_right_idx], array[idx] = array[idx], array[first_right_idx]
          first_right_idx += 1
        end
      end
    end

    # swap pivot with last 'left' element
    if first_right_idx
      array[start], array[first_right_idx - 1] = array[first_right_idx - 1], array[start]
      (first_right_idx - 1)
    else
      start
    end
  end
end
