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
    "Node: #{@value} => #{BinarySearchTree.inorder!(self)}"
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    @root = BinarySearchTree.insert!(@root, value)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
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
    return [] unless node
    left_side = BinarySearchTree.preorder!(node.left)
    right_side = BinarySearchTree.preorder!(node.right)

    [node.value] + left_side + right_side
  end

  def self.inorder!(node)
    return [] unless node
    left_side = BinarySearchTree.inorder!(node.left)
    right_side = BinarySearchTree.inorder!(node.right)

    left_side + [node.value] + right_side
  end

  def self.postorder!(node)
    return [] unless node

    left_side = BinarySearchTree.postorder!(node.left)
    right_side = BinarySearchTree.postorder!(node.right)

    left_side + right_side + [node.value]
  end

  def self.height!(node)
    return -1 unless node
    left_depth = BinarySearchTree.height!(node.left)
    right_depth = BinarySearchTree.height!(node.right)

    [ left_depth, right_depth ].max + 1
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
