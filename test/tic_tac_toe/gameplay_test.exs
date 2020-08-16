defmodule TicTacToe.GamePlayTest do
  use ExUnit.Case
  alias TicTacToe.GamePlay

  describe "is_win?" do
    test "returns true when spaces 1, 2, and 3 are marked with same value" do
      board = %{
        space_1: "X",
        space_2: "X",
        space_3: "X",
        space_4: nil,
        space_5: nil,
        space_6: nil,
        space_7: nil,
        space_8: nil,
        space_9: nil
      }

      actual = GamePlay.is_win?(board)
      expected = true

      assert actual == expected
    end

    test "returns false when spaces 1, and 2 are the same and 3 is different" do
      board = %{
        space_1: "X",
        space_2: "X",
        space_3: "O",
        space_4: "X",
        space_5: nil,
        space_6: nil,
        space_7: nil,
        space_8: nil,
        space_9: nil
      }

      actual = GamePlay.is_win?(board)
      expected = false

      assert actual == expected
    end
  end
end
