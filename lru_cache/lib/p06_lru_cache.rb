require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    link = @map[key]
    if link
      update_link!(link)
    else
      # eject!
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @store.insert(key, @prc.call(key))
    @map[key] = @store.last
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    @store.insert(link.key, link.val)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    link = @store.first
    @store.remove(link)
  end
end
