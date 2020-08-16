defmodule TicTacToe.GamePlay do
  alias TicTacToe.GameState

  def update_game(%GameState{board: board} = game, space) do
    case get_space_value(space, board) do
      nil ->
        game
        |> mark_space(space)
        |> switch_player_turn
        |> check_board_status
        |> update_message

      _ ->
        game
        |> update_message("Can only mark empty spaces.")
    end
  end

  def check_board_status(game) do
    game
    |> maybe_set_draw
    |> maybe_set_win
  end

  def maybe_set_draw(%GameState{board: board} = game) do
    if is_draw?(board) do
      %{
        game
        | game_status: "Draw"
      }
    else
      game
    end
  end

  def maybe_set_win(game) do
    if is_win?(game.board) do
      %{
        game
        | game_status: "Win"
      }
    else
      game
    end
  end

  defguard is_not_nil(value) when value !== nil

  def is_win?(%{space_1: value, space_2: value, space_3: value}) when is_not_nil(value), do: true
  def is_win?(%{space_4: value, space_5: value, space_6: value}) when is_not_nil(value), do: true
  def is_win?(%{space_7: value, space_8: value, space_9: value}) when is_not_nil(value), do: true
  def is_win?(%{space_1: value, space_4: value, space_7: value}) when is_not_nil(value), do: true
  def is_win?(%{space_2: value, space_5: value, space_8: value}) when is_not_nil(value), do: true
  def is_win?(%{space_3: value, space_6: value, space_9: value}) when is_not_nil(value), do: true
  def is_win?(%{space_1: value, space_5: value, space_9: value}) when is_not_nil(value), do: true
  def is_win?(%{space_3: value, space_5: value, space_7: value}) when is_not_nil(value), do: true
  def is_win?(_), do: false

  def is_draw?(board) do
    board_values =
      board
      |> Map.values()

    !Enum.member?(board_values, nil)
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
