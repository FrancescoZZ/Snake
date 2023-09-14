require 'gosu'

class Menu
  def initalize
    @is_on = false
  end

  def is_on?
    @is_on
  end

  def toggle
    @is_on = !@is_on
  end

  def exit
    @is_on = false
  end

  def draw(window)
    font = Gosu::Font.new(window, "Monaco", 60)
    font.draw_text_rel("MENU", 320, 200, 100, 0.5, 0.5, 1, 1, Gosu::Color::RED)
  end
end
