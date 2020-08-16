defmodule TicTacToeWeb.TicTacToeLive do
  alias TicTacToe.{GamePlay, GameState}
  use TicTacToeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :game_state, GameState.init_game())}
  end

  def render(assigns) do
    ~L"""
    <div class="game-header">
      <p>Player 1: <%= @game_state.player_1.name %> || Player 2: <%= @game_state.player_2.name %></p>
      <h2>Game Status: <%= @game_state.game_status %></h2>
      <h2><%= @game_state.message %></h2>
    </div>
    <div class="board">
      <%= for number <- 1..9 do %>
        <button <%= is_in_win_state?(@game_state.game_status) %> class="space" phx-click=<%= get_mark_string(number) %>>
          <%= get_space_value(@game_state.board, number) %>
        </button>
      <% end %>
    </div>
    """
  end

  def handle_event("mark_space_1", _, socket), do: update_game(socket, :space_1)
  def handle_event("mark_space_2", _, socket), do: update_game(socket, :space_2)
  def handle_event("mark_space_3", _, socket), do: update_game(socket, :space_3)
  def handle_event("mark_space_4", _, socket), do: update_game(socket, :space_4)
  def handle_event("mark_space_5", _, socket), do: update_game(socket, :space_5)
  def handle_event("mark_space_6", _, socket), do: update_game(socket, :space_6)
  def handle_event("mark_space_7", _, socket), do: update_game(socket, :space_7)
  def handle_event("mark_space_8", _, socket), do: update_game(socket, :space_8)
  def handle_event("mark_space_9", _, socket), do: update_game(socket, :space_9)

  defp update_game(socket, space) do
    {:noreply,
     assign(socket, :game_state, GamePlay.update_game(socket.assigns.game_state, space))}
  end

  defp is_in_win_state?("Win"), do: "disabled"
  defp is_in_win_state?("Draw"), do: "disabled"
  defp is_in_win_state?(_), do: ""

  defp get_mark_string(number) do
    "mark_space_#{number}"
  end

  def get_space_value(board, space_number) do
    "space_#{space_number}"
    |> String.to_atom()
    |> GamePlay.get_space_value(board)
    |> format_for_ui
  end

  defp format_for_ui(nil), do: ""
  defp format_for_ui(value), do: value
end
