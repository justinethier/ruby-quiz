#!/usr/bin/env ruby -wKU

class AVLNode
 attr_accessor :left, :right, :content
 def initialize
  @content = nil
  @left = @right = nil
end

 def include?(obj)
  (@content == obj) ||
    (@left and @left.include?(obj)) ||
    (@right and @right.include?(obj))  ||
    false
 end
end

class AVLTree

 def initialize
   @content = AVLNode.new
 end

 def empty?
  !@content.value
 end

 def include?(obj)
   
 end

 def <<(obj)
  if empty?
    @content = obj
  else
   @left ||= AVLTree.new
   @right ||= AVLTree.new
    if obj < @content
      @left << obj
     else
      @right <<obj
    end
    balance = @left.height - @right.height
    #if (balance > 1)
    #  pivot = @right
    #  @right  = pivot.left
    #  pivot.left = self
    # end
    if balance > 1
      if (obj < @content)
        if (obj < @left.content) #JAE TODO: x.compareTo (t.left.element) < 0){
          @content, @left, @right = rotateWithLeftChild(self)
        else  
          @content, @left, @right = doubleWithLeftChild(self)
        end
      elsif (obj > @content)
        if (obj > @right.content) #x.compareTo (t.right.element) > 0){
            @content, @left, @right = rotateWithRightChild(self)
        else
            @content, @left, @right = doubleWithRightChild(self)
        end   
      end
    end    
  end
  self
 end

 def rotateWithLeftChild(k2)
  k1 = k2.left

  k2.left = k1.right
  k1.right = k2
  return k1.content, k1.left, k1.right
 end
  
 def doubleWithLeftChild(k3)
  k3.left = rotateWithRightChild(k3.left)
  result = rotateWithLeftChild(k3)
  return result.content, result.left, result.right
 end

 def rotateWithRightChild(k1)
  k2 = k1.right
  k1.right = k2.left
  k2.left = k1
  return k2.content, k2.left, k2.right
 end
 def doubleWithRightChild(k1)
  k1.right = rotateWithLeftChild(k1.right)
  result = rotateWithRightChild(k1)
  return result.content, result.left, result.right
 end


 def height
  lh = (@left && @left.height)||0
  rh = (@right&&@right.height)||0
  1 + [lh,rh].max
 end


 def remove(obj)
  if @content == obj
    @content = nil
  else
    @left.remove(obj)
    @right.remove(obj)
   end
 end

 def value
  @content
 end

end