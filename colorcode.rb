class ColorCode
  def initialize(color1=random, color2=random, color3=random, color4=random)
    @colors = [color1, color, color3, color4]
  end

  def random 
    color_spectrum = ["red", "orange", "yellow", "green", "blue", "indigo", "violet", "white"]
    random = color_spectrum.sample
    @selected_positons ||= []
    until !@selected_positons.include?(random)
      random = color_spectrum.sample
    end
    @selected_positons << random
    random
  end
  
end