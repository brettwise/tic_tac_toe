defmodule TicTacToe.GameState do
  @state ~w(message board player_1 player_2 is_player_one_turn game_status)a
  @enforce_keys @state
  defstruct @state

  def init_game(is_player_one_turn \\ true) do
    %__MODULE__{
      message: get_player_message(is_player_one_turn),
      board: get_new_board(),
      player_1: get_new_player("Enter Name"),
      player_2: get_new_player("Computer"),
      is_player_one_turn: is_player_one_turn,
      game_status: "Not Started"
    }
  end

  def get_player_message(true), do: "Player 1 go!"
  def get_player_message(false), do: "Player 2 go!"

  defp get_new_board do
    %__MODULE__.Board{}
  end

  defp get_new_player(name \\ nil) do
    %{name: name, score: 0}
  end
end
