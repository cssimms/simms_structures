require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head == nil
  end

  def get(key)
    self[key].val if include?(key)
  end

  def include?(key)
    any? {|link| link.key == key}
  end

  def insert(key, val)
    link = Link.new(key, val)
    if empty?
      @head = link
    else
      @tail.next = link
      link.prev = @tail
    end
    @tail = link
  end

  def remove(key)
    link = self[key]
    return nil unless link

    if link == first
      link.next.prev = nil
      @head = link.next
    elsif link == last
      link.prev.next = nil
      @tail = link.prev
    else
      link.prev.next = link.next
      link.next.prev = link.prev
    end
  end

  def each(&block)
    return nil if empty?

    link = first
    loop do
      block.yield(link, link.key)
      link = link.next
      break unless link
    end

  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
