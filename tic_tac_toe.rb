class Game
    attr_accessor :sets, :player_list, :player1, :player2, :spaces

    LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    
    def initialize
        @sets = { "X" => [], "O" => [] }
        @player1 = Player.new(1, "X")
        @player2 = Player.new(2, "O")
        @player_list = [@player1, @player2]
        @board = create_board
        @spaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    end

    def create_board
        board = "\n     |     |     "\
                "\n  1  |  2  |  3  "\
                "\n_____|_____|_____"\
                "\n     |     |     "\
                "\n  4  |  5  |  6  "\
                "\n_____|_____|_____"\
                "\n     |     |     "\
                "\n  7  |  8  |  9  "\
                "\n     |     |     "\
                "\n\n"
    
        puts board
        board
    end

    def new_game
        new_game = Game.new
        new_game.player_turn(new_game.player_list)
    end

    def player_turn(player_list)
        player_list[0].select_space(self, @board, player_list[0].token)
    end

    def swap_player_turn(player_list)
        player_list[0], player_list[1] = player_list[1], player_list[0]
    end

    def take_turn(player_list)
        swap_player_turn(player_list)
        player_turn(player_list)
    end

    def winner?(player, sets)
        LINES.each do |line|
            if (line - sets[player.token]).empty? 
                puts "WINNER PLAYER #{player.player_number} WITH #{player.token} TOKEN"
                new_game()
            else next
            end
        end
        if spaces.empty?
            puts "DRAW. NO WINNER"
            new_game()
        end
    end

end

class Player

    attr_reader :player_number, :token

    def initialize(player_number, token)
        @player_number = player_number
        @token = token
    end

    def select_space(game, board, token)
        puts "Please select a space to place your #{token}"
        space = gets.chomp
        unless game.spaces.include?(space)
            select_space(game, board, token)
        else
            board[space] = token
            game.sets[token].push(space.to_i)
            game.spaces.delete(space)
        end
        puts board
        game.winner?(self, game.sets)
        if game.spaces.empty?
            puts "DRAW. NO WINNER"
            game.new_game()
        end
        game.take_turn(game.player_list)
    end

end

game = Game.new
game.player_turn(game.player_list)