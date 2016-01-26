def move(snake, direction)
  new_snake = snake.clone
  new_snake.delete_at 0
  new_snake << [snake[-1][0] + direction[0], snake[-1][1] + direction[1]]
end

def grow(snake, direction)
  new_snake = move snake, direction
  new_snake.insert 0, snake[0]
end

def new_food(food, snake, dimensions)
  xs, ys = Array(0..dimensions[:width] - 1), Array(0..dimensions[:height] - 1)
  table = xs.product ys
  table = table - snake - food
  index = rand(0..table.length - 1)
  table[index]
end

def obstacle_ahead?(snake, direction, dimensions)
  next_state = move snake, direction
  xs, ys = next_state[-1][0], next_state[-1][1]
  last_x, last_y = dimensions[:width], dimensions[:height]
  on_border = xs == last_x || ys == last_y
  on_border || snake.include?([xs, ys])
end

def danger?(snake, direction, dimensions)
  next_state = move snake, direction
  instant_danger = obstacle_ahead? snake, direction, dimensions
  obstacle_ahead? next_state, direction, dimensions or instant_danger
end
