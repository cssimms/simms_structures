require 'byebug'

class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def inspect
    "Node: #{@value}"
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)

  end

  def find(value)

  end

  def inorder

  end

  def postorder

  end

  def preorder

  end

  def height

  end

  def min

  end

  def max

  end

  def delete(value)

  end

  def self.insert!(node = nil, value)
    if node
      if value > node.value
        node.right = BinarySearchTree.insert!(node.right, value)
      else
        node.left = BinarySearchTree.insert!(node.left, value)
      end

      node
    else
      BSTNode.new(value)
    end
  end

  def self.find!(node, value)
    return nil unless node

    case node.value <=> value
    when 0
      node
    when 1
      BinarySearchTree.find!(node.left, value)
    when -1
      BinarySearchTree.find!(node.right, value)
    end
  end

  def self.preorder!(node)

  end

  def self.inorder!(node)

  end

  def self.postorder!(node)

  end

  def self.height!(node)
    return -1 unless node
    left_depth = BinarySearchTree.height!(node.left)
    right_depth = BinarySearchTree.height!(node.right)

    deepest_depth = left_depth > right_depth ? left_depth : right_depth
    deepest_depth + 1
  end

  def self.max(node)
    return nil unless node
    return node unless node.right

    max = node
    child_max = BinarySearchTree.max(node.right)
    max.value > child_max.value ? max : child_max
  end

  def self.min(node)
    return nil unless node
    return node unless node.left

    min = node
    child_min = BinarySearchTree.min(node.left)
    min.value < child_min.value ? min : child_min
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left
    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete_max!(node)
    return nil unless node
    return node.left unless node.right
    node.right = BinarySearchTree.delete_max!(node.right)
    node
  end

  def self.delete!(node, value)
    return nil unless node

    case node.value <=> value
    when 0
      if node.right
        right_min = BinarySearchTree.min(node.right)
        node.value, right_min.value = right_min.value, node.value
        BinarySearchTree.delete_min(node)

      elsif node.left
        left_max = BinarySearchTree.max(node.left)
        node.value, left_max.value = left_max.value, node.value
        BinarySearchTree.delete_max(node)
      else
        nil
      end
    when 1
      node.left = BinarySearchTree.delete!(node.left, value)
    when -1
      node.right = BinarySearchTree.delete!(node.right, value)
    end
  end
end
