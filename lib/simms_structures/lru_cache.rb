require_relative 'hash_map'
require_relative 'linked_list'

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
      link.val
    else
      eject! if @map.count == @max
      calc!(key).val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  # insert an (un-cached) key
  def calc!(key)
    @store.insert(key, @prc.call(key))
    @map[key] = @store.last
  end

  # move a link to the end of the list
  def update_link!(link)
    @store.insert(link.key, link.val)
  end

  def eject!
    link = @store.first
    @store.remove(link)
  end
end
