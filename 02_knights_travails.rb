def knight_moves(source, target)
  range = [0, 1, 2, 3, 4, 5, 6, 7]
  moves = [[1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2]]
  move_stack = []
  start = Node.new(source)
  move_stack += Array(start)
  pop = nil
  
  # LIFO
  while(move_stack.length != 0)
    pop = move_stack[0]
    break if(pop.value == target)
    
    move_stack.delete_at(0)
    x = pop.value[0]
    y = pop.value[1]
    
    # Create a node for each possible move
    temp_array = []
    # TODO L move not single move!!!!!!!!!!!!!!
    moves.each do |move|
      move_x = move[0]
      move_y = move[1]
      temp_array += Array(Node.new([x + move_x, y + move_y])) if(range.include?(x + move_x) && range.include?(y + move_y))
      #puts "[#{x + move_x}, #{y + move_y}] added!" if(range.include?(x + move_x) && range.include?(y + move_y))
    end
    
    temp_array.each do |node|
      node.parent = pop
      move_stack += Array(node)
    end
  end
  #up[0] = source[0]
  #up[1] = source[1] - 1
  
  pointer = pop
  path = []
  while(pointer != nil)
    path += Array(pointer)
    pointer = pointer.parent
  end
  path.reverse!
  
  puts "You made it in #{path.length - 1} moves!  Here's your path:"
  path.each do |node|
    puts "#{node.value}"
  end
  
end

# Node data structure to be used for tracing the path from the source to the target
class Node
  attr_accessor :parent, :value
  
  def initialize(value)
    @parent = nil
    @value = value
  end
end

knight_moves([3,3],[4,3])