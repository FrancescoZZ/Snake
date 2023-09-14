require 'gosu'
require_relative 'snake'
require_relative 'food'
require_relative 'menu'

class Window < Gosu::Window
  def initialize
    super 640, 480, false, update_interval = 60.0
    self.caption = "GosuSnake"
    @player = Snake.new
    @food = Food.new
    @menu = Menu.new
    @score_font = Gosu::Font.new(self, "Monaco", 20)
    @game_over = Gosu::Font.new(self, "Monaco", 60)
  end

  def update
    unless @menu.is_on?
      @player.next
      unless @player.is_dead?
        @player.move
        if @player.xy == @food.xy
          @player.eat(@food.xy)
          @food = Food.new
        end
      end
    end
  end

  def draw
    @menu.draw(self) if @menu.is_on?
    @player.draw
    @food.draw
    if @player.is_dead?
      Gosu.draw_rect(0, 0, 640, 2, Gosu::Color::RED)
      Gosu.draw_rect(0, 0, 2, 480, Gosu::Color::RED)
      Gosu.draw_rect(638, 0, 2, 480, Gosu::Color::RED)
      Gosu.draw_rect(0, 478, 640, 2, Gosu::Color::RED)
      @game_over.draw_text_rel("GAME OVER", 320, 200, 100, 0.5, 0.5, 1, 1, Gosu::Color::RED)
      @score_font.draw_text_rel("SCORE: #{@player.score}", 320, 260, 100, 0.5, 0.5, 1, 1, Gosu::Color::RED)
      @score_font.draw_text_rel("PRESS N FOR NEW GAME", 320, 280, 100, 0.5, 0.5, 1, 1, Gosu::Color::RED)
    else
      @score_font.draw_text(@player.score, 20, 20, 100, 1, 1)
    end
  end


  def button_down(id)
    unless @menu.is_on?
      if id == Gosu::KB_LEFT
        @player.turn_left
      elsif id == Gosu::KB_RIGHT
        @player.turn_right
      elsif id == Gosu::KB_UP
        @player.turn_up
      elsif id == Gosu::KB_DOWN
        @player.turn_down
      end
    end
    if id == Gosu::KB_ESCAPE
      close
    elsif id == Gosu::KB_M
      @menu.toggle
    elsif id == Gosu::KB_N
      initialize
    else
      super
    end
  end
end

