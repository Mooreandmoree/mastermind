# frozen_string_literal: true

class ColorCode
  def initialize(color1 = random, color2 = random, color3 = random, color4 = random)
    @colors = [color1, color2, color3, color4]
  end

  def random
    color_spectrum = %w[red orange yellow green blue indigo violet white]
    random = color_spectrum.sample
    @selected_positions ||= []
    random = color_spectrum.sample while @selected_positions.include?(random)
    @selected_positions << random
    random
  end
end
