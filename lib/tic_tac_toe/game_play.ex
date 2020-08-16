defmodule TicTacToe.GamePlay do
  alias TicTacToe.GameState

  def update_game(%GameState{board: board} = game, space) do
    if space_previously_marked?(space, board) do
      "Can only mark empty spaces ya dingus!"
      |> update_message(game)
    else
      game
      |> mark_space(space)
      |> switch_player_turn
      |> check_board_status
      |> update_message
    end
  end

  defp space_previously_marked?(space, board) do
    if get_space_value(space, board), do: true, else: false
  end

  def mark_space(%GameState{is_player_one_turn: true} = game, space) do
    mark_board(game, space, "X")
  end

  def mark_space(%GameState{is_player_one_turn: false} = game, space) do
    mark_board(game, space, "O")
  end

  def switch_player_turn(%GameState{is_player_one_turn: is_player_one_turn} = game) do
    %{game | is_player_one_turn: !is_player_one_turn}
  end

  def check_board_status(game) do
    game
    |> maybe_set_draw
    |> maybe_set_win
  end

  def maybe_set_draw(%GameState{board: board} = game) do
    if is_draw?(board), do: mark_game_status(game, "Draw"), else: game
  end

  def is_draw?(board), do: !Enum.member?(Map.values(board), nil)

  def maybe_set_win(game) do
    if is_win?(game.board), do: mark_game_status(game, "Win"), else: game
  end

  defp mark_game_status(game, status), do: %{game | game_status: status}

  defguard is_not_nil(value) when value !== nil

  def is_win?(%{space_1: mark, space_2: mark, space_3: mark}) when is_not_nil(mark), do: true
  def is_win?(%{space_4: mark, space_5: mark, space_6: mark}) when is_not_nil(mark), do: true
  def is_win?(%{space_7: mark, space_8: mark, space_9: mark}) when is_not_nil(mark), do: true
  def is_win?(%{space_1: mark, space_4: mark, space_7: mark}) when is_not_nil(mark), do: true
  def is_win?(%{space_2: mark, space_5: mark, space_8: mark}) when is_not_nil(mark), do: true
  def is_win?(%{space_3: mark, space_6: mark, space_9: mark}) when is_not_nil(mark), do: true
  def is_win?(%{space_1: mark, space_5: mark, space_9: mark}) when is_not_nil(mark), do: true
  def is_win?(%{space_3: mark, space_5: mark, space_7: mark}) when is_not_nil(mark), do: true
  def is_win?(_), do: false

  def get_space_value(space, board), do: Map.get(board, space)

  defp mark_board(game, space, marker) do
    %{game | board: Map.put(game.board, space, marker)}
  end

  def update_message(game) do
    %{game | message: GameState.get_player_message(game.is_player_one_turn)}
  end

  def update_message(message, game), do: %{game | message: message}
end
