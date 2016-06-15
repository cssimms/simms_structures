require_relative 'hashing'
require_relative 'linked_list'

class HashMap

  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    include?(key) ? delete(key) : (@count += 1)
    bucket(key).insert(key, val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count-= 1 if bucket(key).remove(key)
  end

  def each(&block)
    @store.each do |bucket|
      bucket.each do |link|
        block.yield(link.key, link.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  # private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new( num_buckets * 2 ) { LinkedList.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each do |link|
        self[link.key] = link.val
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
