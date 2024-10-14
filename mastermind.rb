# frozen_string_literal: true
require_relative 'gameboard.rb'
require_relative 'colorcode.rb'
require_relative 'hint.rb'
require_relative 'computer.rb'

class Mastermind
  attr_accessor :gameboard, :win, :turns, :color_spectrum, :player_mode, :computer
     def initialize
          @gameboard = GameBoard.new()
          @win = false
          @turns = 1
          @color_spectrum %w[red orange yellow green blue indigo violet white]
          @player_mode = true
          @computer = Computer.new()
     end
     
     def play 
      instructions
      prompt_switch_mode
      set_solution if player_mode = false
      start
     end

     def instructions
     puts "  __  __

     |  \\/  | __ _  ___| |_  ___  _ _  _ __  (_) _ _   __| |
     | |\\/| |/ _` |(_-<|  _|/ -_)| '_|| '  \\ | || ' \\ / _` |
     |_|  |_|\\__,_|/__/ \\__|\\___||_|  |_|_|_||_||_||_|\\__,_|"
    puts "Welcome to mastermind, do you feel you ar codebreaker ? you can test it out here let's see what you got! "
    puts "________________________________________________________________\n\n"
    puts "Guess the code to win!"
    puts "The computer will select a code of four different colors in a specific order "
    puts "You will have twelve guesses."
    @gameboard.display
    puts "__________________________________________________________________\n\n"
    puts "The left side is where your guesses will go"
    puts "The right side will tell you how accurate you are: "
		puts "green for every color in the correct position"
		puts "red for every color in an incorrect position!" 
		puts "\nGood luck if you want it!"
		puts "_________________________________________________________\n\n> "
    end
    
    def prompt_switch_mode
      puts "Do you want to play as a code breaker or a code maker ? "
      print "Say \"computer\" or \"me\. \n "
      mode = gets.chomp
      until mode == "computer" || "me"
        puts "Sorry i didn't quite get your type of mode. Say \"computer\" or \"me\" \n> "
        mode = gets.chomp
      end
      puts ""
      @player_mode = false if mode == "computer"
    end

    def set_solution
      puts "What would you like your secret solution to be?"
		  puts "\nType four colors separated by spaces."
      puts "Your choices are: red, orange, yellow, green, blue, indigo, violet, white \n> "
      solution = get_player_guess
      @gameboard.solution = ColorCode.new(solution[0], solution[1], solution[2], solution[3])  
    end
    
    def start
      make_guesses
      turns > 12 ? lose : win
    end

    def make_guesses
      while win == false && @turns < 13
        @win = true if gameboard.guesses[12 - @turns].colors == gameboard.solution.colors
        @turns += 1 if @win == false
      end
    end

    def prompt_switch_mode
      puts @player_mode ? "What is your #{@turns} guess! " : "\nComputer Make your #{@turns} guess!"
      puts "Select from one of this four colors seperated by spaces "
      print "Your choices are: red, orange, yellow, green, blue, indigo, violet, white \n> "
    end 
     
    def get_player_guess
      1.times do
        guess = gets.chomp.downcase.split(" ")
        if guess.length != 4
          print "You have entered the wrong amount of colors for guessing \n> "
          redo
        end

        if !@color_spectrum.include?(guess[0]) || !@color_spectrum.include?(guess[1]) || !@color_spectrum.include?(guess[2]) || !@color_spectrum.include?(guess[3] )  
          puts "Your colors are not from the specified set of colors available for guessing \n>"
          redo
        end

        if @player_mode == false 
          if guess.uniq.length != 4
          puts  "You must have different colors for the solution! \n> "
          redo 
          end
        end 

        return guess 

      end
    end
    
    def computer_guess
      @computer.guess(@gameboard.hints, @turns)
    end 
     
    def add_guess(guess)
      gameboard.guesses[12 - @turns] = ColorCode.new(guess[0], guess[1], guess[2], guess[3])
      gameboard.refresh(12 - @turns)
    end
  
    def lose
      puts @player_mode ? "You have failed to crack the puzzle! It's okay; you're just not smart." : "No... I have failed."
      puts "The solution was #{@gameboard.solution.colors}."
    end
  
    def win
      puts @player_mode ? "\nYou have solved the code! Amazing!" : "\nI have solved the code, you measly human. Next I will destroy you!"
    end
  end
  
  game = Mastermind.new()
  game.play











     end
end
