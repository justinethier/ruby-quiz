#!/usr/bin/env ruby -wKU

class AvlNode {
	AvlNode (Comparable theElement){
		this (theElement, null, null);
	}
	
	AvlNode (Comparable theElement, AvlNode lt, AvlNode rt){
		element = theElement;
		left = lt;
		right = rt;
	}
	
	Comparable	element;	// Node data
	AvlNode		left;		// Left child
	AvlNode		right;		// Right child
	int			height;		// Height of node
}

class AVLTree
  def << (node)
    puts node
  end
  
  def empty?
    false
  end
  
  def tree.include?(item)
  end
end

avl = AVLTree.new
avl << 3