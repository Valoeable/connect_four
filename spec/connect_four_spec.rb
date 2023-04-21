require './lib/connect_four'

describe GameBoard do
    describe '#check_for_game_over' do
        context 'when player wins' do
            subject(:test_field) { described_class.new(player1, player2) }
            let(:player1) { Player.new(1) }
            let(:player2) { Player.new(2) }

            it 'returns true to end_game instance variable for horizontal chips' do
                test_field.instance_variable_set(:@end_game, false)
                updated_field = test_field.instance_variable_get(:@field)
                updated_field[5][0] = player1.mark
                updated_field[5][1] = player1.mark
                updated_field[5][2] = player1.mark
                updated_field[5][3] = player1.mark
                test_field.instance_variable_set(:@field, updated_field)

                test_field.check_for_game_over(player1)
                g_over = test_field.instance_variable_get(:end_game)
                expect(g_over).to be true
            end

            it 'returns true to end_game instance variable for vertical chips' do
                test_field.instance_variable_set(:@end_game, false)
                updated_field = test_field.instance_variable_get(:@field)
                updated_field[5][0] = player1.mark
                updated_field[4][0] = player1.mark
                updated_field[3][0] = player1.mark
                updated_field[2][0] = player1.mark
                test_field.instance_variable_set(:@field, updated_field)

                test_field.check_for_game_over(player1)
                g_over = test_field.instance_variable_get(:end_game)
                expect(g_over).to be true
            end

            it 'returns true to end_game instance variable for diagonal chips' do
                test_field.instance_variable_set(:@end_game, false)
                updated_field = test_field.instance_variable_get(:@field)
                updated_field[5][0] = player1.mark
                updated_field[4][1] = player1.mark
                updated_field[3][2] = player1.mark
                updated_field[2][3] = player1.mark
                test_field.instance_variable_set(:@field, updated_field)

                test_field.check_for_game_over(player1)
                g_over = test_field.instance_variable_get(:end_game)
                expect(g_over).to be true
            end
        end
    end
end

