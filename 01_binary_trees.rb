class Node
  attr_accessor :value, :parent, :children, :left, :right
  
  def initialize
    @value = -1
    @parent = nil
    @left = nil
    @right = nil
  end
  
end

# Builds a binary tree and returns the root of the tree
def build_tree(data_array)
  #children = n * 2 + 1 and + 2
  node_array = []
  
  # Convert all data into Nodes
  data_array.each do |element|
    to_add = Node.new
    to_add.value = element
    node_array += Array(to_add)
  end
  
  temp_array = node_array.dup
  sorted_array = []
  
  # Extract the smallest node and push it into sorted_array
  # The tree will be sorted by default
  while(temp_array.length != 0)
    min_val = 999_999_999
    min_index = -1
    
    # Find the smallest node
    temp_array.each_with_index do |node, index|
      if(node.value < min_val)
        min_val = node.value
        min_index = index
      end
    end
    
    # Remove it and push it into sorted_array
    sorted_array += Array(temp_array[min_index])
    temp_array.delete_at(min_index)
  end
  
  node_array = sorted_array
  
  # Link the nodes together
  node_array.each_with_index do |node, index|
    for i in (1..2) do
      if(node_array[index * 2 + i] != nil)
        node.left = node_array[index * 2 + i] if(i == 1)
        node.right = node_array[index * 2 + i] if(i == 2)
        node_array[index * 2 + i].parent = node
      end
    end
  end
  
  return node_array[0]
  #return node_array
end

def bfs(target, root)
  queue = []
  
  queue += Array(root)
  
  # FIFO
  while(queue.length != 0)
    # "Pop" the front of the queue
    pop = queue[0]
    return pop if(pop.value == target)
    
    queue.delete_at(0)
    queue += Array(pop.left)
    queue += Array(pop.right)
  end
  
  return nil
end

def dfs(target, root)
  stack = []
  
  stack += Array(root)
  
  # LIFO
  while(stack.length != 0)
    # "Pop" the top of the stack
    pop = stack[-1]
    return pop if(pop.value == target)
    
    stack.delete_at(-1)
    stack += Array(pop.right)
    stack += Array(pop.left)
  end
  
  return nil
end

# Recursive DFS
def dfs_rec(target, node)
  return nil if(node == nil)
  return node if(node.value == target)
  
  left_result = dfs_rec(target, node.left)
  right_result = dfs_rec(target, node.right)
  
  return left_result if(left_result != nil)
  return right_result if(right_result != nil)
end

head = build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts "#{head.right.right.left.value}"
bbfs = bfs(6345, head)
puts "6345's BFS parent is #{bbfs.parent.value}"
ddfs = dfs(6345, head)
puts "6345's DFS parent is #{ddfs.parent.value}"
rdfs = dfs_rec(6345, head)
puts "6345's rec-DFS parent is #{rdfs.parent.value}"
#head.each do |node|
#  print "#{node.value}, "
#end

#n = Node.new
#n2 = Node.new