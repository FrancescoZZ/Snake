require 'gosu'
require 'matrix'

class Snake
  def initialize
    @speed = 20
    @right = Vector[@speed, 0]
    @left  = Vector[-@speed, 0]
    @down  = Vector[0, @speed]
    @up    = Vector[0, -@speed]

    @body = [Vector[80,80]]
    @undigested = []
    @dead = false

    @vel = @right
    @direction = @right
    @next_move = @body[0]

    @score = 0
  end

  def xy
    @body.first
  end

  def score
    @score
  end

  def turn_right
    @vel = @right unless @direction == @left
  end

  def turn_left
    @vel = @left unless @direction == @right
  end

  def turn_down
    @vel = @down unless @direction == @up
  end

  def turn_up
    @vel = @up unless @direction == @down
  end

  def next
    @next_move += @vel
  end
  
  def move
    @body = @body.rotate(-1)[1..].prepend(@body[0])
    @body[0] += @vel
    @direction = @vel
    unless (@body.include?(@undigested[0]) || @undigested[0].nil?)
      @body << @undigested.delete_at(0)
    end
  end

  def eat(food)
    @score += 10
    @undigested << food 
  end

  def is_dead?
    @dead = true if @body[1..].include?(@next_move)
    @dead = true if [640, -20].include? @next_move[0]
    @dead = true if [480, -20].include? @next_move[1]
    return @dead
  end

  def draw
    @body.each do |segment|
      Gosu.draw_rect(segment[0], segment[1], 20, 20, Gosu::Color.argb(0xff_ffffff))
    end
  end
end
