#!/usr/bin/env ruby -wKU

class TreeNode

 attr_accessor :left, :right, :data #, :parent

 def initialize(obj = nil)
   @left=nil
   @right=nil
   @data=obj
   #@parent=nil
 end

 def attach_left node
   @left = node
   #node.parent = self
 end

 def attach_right node
   @right = node
   #node.parent = self
 end

 def height
   [(left.height rescue 0) , (right.height rescue 0)].max + 1
   #node_height += 1 if data != nil
   #node_height
 end

 def include? obj
   (@data == obj) ||
     (@left.include? obj rescue false) ||
     (@right.include? obj rescue false)
 end

 def length
   len = 1
   len += @left.length if left
   len += @right.length if right
 end

end

class AVLTree

 def initialize
  @root = nil
 end

 def empty?
  ! @root
 end

 def include?(obj)
  (! empty?) && (@root.include? obj)
 end

 def <<(obj)
   if empty?
     @root = TreeNode.new obj
   else
     @root = insert(obj, @root)
   end
   self
 end

 def insert(obj, node)
   if node == nil
     node = TreeNode.new(obj)
   elsif obj < node.data
     node.left = insert(obj, node.left)
   elsif obj > node.data
     node.right = insert(obj, node.right)
  end
  
   balance = (node.left.height rescue 0)  - (node.right.height rescue 0).abs
   if balance > 1
    if (obj < node.data)
      if (obj < node.left.data)
        node = rotate_with_left_child(node)
      end
    end
   end
   node
 end

 def rotate_with_left_child(node)
  new_parent = node.left

  node.left = new_parent.right
  new_parent.right = node
  new_parent
 end

 def height
  empty? ? 0 : @root.height
 end

 def each
   list = list_nodes(@root, [])
   for data in list
     yield data
   end
 end
 
 def list_nodes(node, list)
   list_nodes(node.left, list) if node.left != nil
   list << node.data if node.data != nil
   list_nodes(node.right, list) if node.right != nil
   list
 end
end

=begin
    if (obj < node.data)
      if (obj < node.left.data) #JAE TODO: x.compareTo (t.left.element) < 0){
        node = rotateWithLeftChild(node)
      else  
        node = doubleWithLeftChild(node)
      end
    elsif (obj > node.data)
      if (obj > node.right.data) #x.compareTo (t.right.element) > 0){
          node = rotateWithRightChild(node)
      else
          node = doubleWithRightChild(node)
      end   
    end
   end 

 end

 def rotateWithLeftChild(k2)
  k1 = k2.left

  k2.left = k1.right
  k1.right = k2
  k1
 end
  
 def doubleWithLeftChild(k3)
  k3.left = rotateWithRightChild(k3.left)
  return rotateWithLeftChild(k3)
 end

 def rotateWithRightChild(k1)
  k2 = k1.right
  k1.right = k2.left
  k2.left = k1
  k2
 end

 def doubleWithRightChild(k1)
  k1.right = rotateWithLeftChild(k1.right)
  return rotateWithRightChild(k1)
 end

=end
