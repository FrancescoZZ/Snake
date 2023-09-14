require 'gosu'
require 'matrix'

class Food
  def initialize
    @x = rand(31) * 20
    @y = rand(23) * 20
    #@font = Gosu::Font.new(window, font, size)
  end

  def xy
    Vector[@x, @y]
  end

  def draw
    Gosu.draw_rect(@x, @y, 20, 20, Gosu::Color.argb(0xff_ff0000))
    #@font.draw_text("*", @x, @y, 100, 1, 1)
  end 
end
