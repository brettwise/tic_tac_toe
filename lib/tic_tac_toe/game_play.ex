defmodule TicTacToe.GamePlay do
  alias TicTacToe.GameState
  def update_game(%GameState{board: board} = game, space) do
    case get_space_value(space, board) do
      nil ->
        game
        |> mark_space(space)
        |> switch_player_turn
        |> update_message
      _ ->
        game
        |> update_message("Can only mark empty spaces.")
    end
  end

  def get_space_value(space, board), do: Map.get(board, space)

  def mark_space(%GameState{is_player_one_turn: true, board: board} = game, space) do
    %{
      game
      | board: Map.put(board, space, "X")
    }
  end

  def mark_space(%GameState{is_player_one_turn: false, board: board} = game, space) do
    %{
      game
      | board: Map.put(board, space, "O")
    }
  end

  def switch_player_turn(%GameState{is_player_one_turn: is_player_one_turn} = game) do
    %{
      game
      | is_player_one_turn: !is_player_one_turn
    }
  end

  def update_message(game) do
    %{
      game
      | message: GameState.get_player_message(game.is_player_one_turn)
    }
  end

  def update_message(game, message) do
    %{
      game
      | message: message
    }
  end
end
