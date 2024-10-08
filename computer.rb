# frozen_string_literal: true

class Computer
  attr_accessor :color_spectrum, :guess_set, :correct_colors

  def initialize
    @color_spectrum = %w[red orange yellow green blue indigo violet white]
    @guess_set = 0
    @correct_colors = []
  end

  def guess(hints, turns)
    computer_guess = get_guess(hints, turns)
    print "#{computer_guess[0]}, #{computer_guess[1]}, #{computer_guess[2]}, #{computer_guess[3]}\n"
    computer_guess
  end

  def get_guess(hints, turns)
    computer_guess = []
    if @correct_colors.uniq.length != 4
      case turn
      when 1
        4.times { computer_guess << @color_spectrum[@guess_set] }

        @guess_set += 1
      when 2..8
        4.times { computer_guess << @color_spectrum[@guess_set] }
        @correct_colors << @color_spectrum[@guess_set - 1] if color_is_correct(hints, turns)
        guess_set + 1 if guess_set < 8
      when 9
        @correct_colors << @color_spectrum[@guess_set - 1] if color_is_correct(hints, turns)
        computer_guess = @correct_colors
        @correct_colors = @correct_colors.shuffle
      else
        computer_guess = @correct_colors
        @correct_colors = @correct_colors.shuffle
      end
    else
      computer_guess = @correct_colors
      @correct_colors = @correct_colors.shuffle
    end
    computer_guess
  end

  def color_is_correct(hints, turn)
    hints[12 - turn + 1].colors[0] == 'green'
  end
end
