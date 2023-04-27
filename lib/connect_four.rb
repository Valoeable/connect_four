class GameBoard
    attr_accessor :field, :winner, :end_game, :turn_counter, :full_column_turn

    def initialize(pl1, pl2)
        @field = Array.new(6) { Array.new(7) { "\u25ef" } }
        @pl1 = pl1
        @pl2 = pl2
        @winner = nil
        @end_game = false
        @turn_counter = 0
        @full_column_turn = 0
        game
    end

    def display_field
        r1 = "| #{@field[0][0]} | #{@field[0][1]} | #{@field[0][2]} | #{@field[0][3]} | #{@field[0][4]} | #{@field[0][5]} | #{@field[0][6]} |"
        r2 = "| #{@field[1][0]} | #{@field[1][1]} | #{@field[1][2]} | #{@field[1][3]} | #{@field[1][4]} | #{@field[1][5]} | #{@field[1][6]} |"
        r3 = "| #{@field[2][0]} | #{@field[2][1]} | #{@field[2][2]} | #{@field[2][3]} | #{@field[2][4]} | #{@field[2][5]} | #{@field[2][6]} |"
        r4 = "| #{@field[3][0]} | #{@field[3][1]} | #{@field[3][2]} | #{@field[3][3]} | #{@field[3][4]} | #{@field[3][5]} | #{@field[3][6]} |"
        r5 = "| #{@field[4][0]} | #{@field[4][1]} | #{@field[4][2]} | #{@field[4][3]} | #{@field[4][4]} | #{@field[4][5]} | #{@field[4][6]} |"
        r6 = "| #{@field[5][0]} | #{@field[5][1]} | #{@field[5][2]} | #{@field[5][3]} | #{@field[5][4]} | #{@field[5][5]} | #{@field[5][6]} |"
        divide = '+---+---+---+---+---+---+---+'
        puts r1
        puts divide
        puts r2
        puts divide
        puts r3
        puts divide
        puts r4
        puts divide
        puts r5
        puts divide
        puts r6
        puts divide
    end

    def game
        curr_player = @pl1

        until @end_game
            clear if @full_column_turn.zero?
            @full_column_turn = 0
            display_field
            puts("#{curr_player.name}, insert the chip into the column of your choice:")
            chosen_column = gets.chomp.to_i - 1

            if @field[0][chosen_column].include?(@pl1.mark) || @field[0][chosen_column].include?(@pl2.mark)
                puts('This column is full, please choose another column.')
                @full_column_turn += 1
                next
            end
            
            chip_insertion(chosen_column, curr_player)
            @turn_counter += 1

            check_for_game_over(curr_player)
            @end_game = true if @turn_counter == 42

            curr_player == @pl1 ? curr_player = @pl2 : curr_player = @pl1
        end
        clear
        display_field
        display_winner
    end

    def chip_insertion(chosen_column, curr_player)
        i = 0

        i += 1 until i == 5 || @field[i + 1][chosen_column] == @pl1.mark || @field[i + 1][chosen_column] == @pl2.mark

        @field[i][chosen_column] = curr_player.mark
    end

    def check_for_game_over(curr_player)
        6.times do |r|
            7.times do |c|
                if self.check_combos(r, c, curr_player.mark)
                    @end_game = true
                    @winner = curr_player
                end
            end
        end
    end

    def check_combos(row, column, mark)
        horizontal?(row, column, mark) || vertical?(row, column, mark) || diagonal?(row, column, mark)
    end

    def horizontal?(row, column, mark)
        return if column > 3

        @field[row][column] == mark && @field[row][column + 1] == mark && @field[row][column + 2] == mark && @field[row][column + 3] == mark
    end

    def vertical?(row, column, mark)
        return if row > 2 

        @field[row][column] == mark && @field[row + 1][column] == mark && @field[row + 2][column] == mark && @field[row + 3][column] == mark
    end

    def diagonal?(row, column, mark)
        return unless row < 3

        diagonal_left?(row, column, mark) || diagonal_right?(row, column, mark)
    end

    def diagonal_left?(row, column, mark)
        return if column > 3

        @field[row][column] == mark && @field[row + 1][column + 1] == mark && @field[row + 2][column + 2] == mark && @field[row + 3][column + 3] == mark
    end

    def diagonal_right?(row, column, mark)
        return if column < 3

        @field[row][column] == mark && @field[row + 1][column - 1] == mark && @field[row + 2][column - 2] == mark && @field[row + 3][column - 3] == mark
    end

    def display_winner
        if @turn_counter == 42
            puts('It ended in a tie!')
        else
            puts("The winner is #{@winner.name}, congratulations!")
        end
    end

end

class Player
    attr_accessor :mark, :name

    def initialize(player_number)
        recieve_name(player_number)
        recieve_mark(player_number)
    end

    def recieve_name(player_number)
        clear
        puts "Player #{player_number}, please select your name:"
        @name = gets.chomp
    end

    def recieve_mark(player_number)
        player_number == 1 ? @mark = "\u262e" : @mark = "\u262f"
    end
end

def clear
    print "\e[2J\e[H"
end


