# My Simple Stack class
# I just felt like defining my own Stack class for clarity in the other classes

class Stack
  def initialize
    @store = []
  end

  def push(el)
    @store.push(el)
  end

  def pop
    @store.pop
  end

  def empty?
    @store.empty?
  end
end

# Three Stacks implemented with only one array
# Uses Modular Arithmetic to distribute values accross the array
# This implementation is of course pretty bad for Space Complexity, as we have
# to store empty fields to accomidate the space for one stack being longer than
# the others. This is a fine solution if we expect our Stacks to contain
# roughly the same number of elements, though.

class ThreeStacks
  def initialize
    @store = []
    @count1, @count2, @count3 = 0, 0, 0
  end

  def push1(el)
    @store[@count1 * 3] = el
    @count1 += 1
  end

  def pop1
    @count1 -= 1
    value = @store[@count1 * 3]
    @store[@count1 * 3] = nil
    value
  end

  def push2(el)
    @store[@count2 * 3 + 1] = el
    @count2 += 1
  end

  def pop2
    @count2 -= 1
    value = @store[@count2 * 3 + 1]
    @store[@count2 * 3 + 1] = nil
    value
  end

  def push3(el)
    @store[@count3 * 3 + 2] = el
    @count3 += 1
  end

  def pop3
    @count3 -= 1
    value = @store[@count3 * 3 + 2]
    @store[@count3 * 3 + 2] = nil
    value
  end
end

# StackQueue
# A Queue implemented with two Stacks

class StackQueue
  def initialize
    @first = Stack.new
    @second = Stack.new
  end

  def enqueue(el)
    @first.push(el)
  end

  def dequeue
    slinkify! if @second.empty?
    @second.pop
  end

  private

# Called slinkify because... slinkies!

  def slinkify!
    raise 'Queue is empty!' if @first.empty?
    until @first.empty?
      @second.push(@first.pop)
    end
  end
end
