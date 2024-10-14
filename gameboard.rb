# frozen_string_literal: true

require 'colorize'

class GameBoard
  attr_accessor :solution, :guesses, :hints

  def initialize
    @solution = ColorCode.new
    @guesses = Array.new(12, ColorCode.new('blank', 'blank', 'blank', 'blank'))
    @hints = Array.new(12, Hint.new('blank', 'blank', 'blank', 'blank'))
  end

  def display
    puts '______________________________'
    puts(@guesses.each_with_index { |guess, _index| puts "|#{colorize(guess, true)} | #{colorize(hints, false)} |" })
    puts '------------------------------'
  end

  def refresh(row_index)
    evaluate(row_index)
    display
  end

  def evaluate(row_index)
    correct_colors = 0
    @guesses[row_index].colors.each_with_index do |color, index|
      correct_colors += 1 if @solution.colors[index] == color
    end
    misplaced_correct_colors = @guesses[row_index].colors.select { |color|
      @solution.colors.include?(color) == true
    }.uniq.length - correct_colors

    colors = []

    correct_colors.times do
      colors << 'green'
    end

    misplaced_correct_colors.times do
      colors << 'red'
    end

    colors << 'blank' until colors.length == 4

    @hints[index] = Hint.new(colors[0], colors[1], colors[2], colors[3])
  end

  def colorize(set, is_color_code)
    colors = []
    text = is_color_code ? 'O' : '.'
    set.colors.each { |color| colors.push(text.public_send(color.to_sym)) }
    colors.join(' ')
  end
end
