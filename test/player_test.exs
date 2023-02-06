defmodule ExMon.PlayerTest do
  use ExUnit.Case
  alias ExMon.Player

  describe "build/4" do
    test "returns a structured player" do
      expected_response_player = %Player{
        life: 100,
        moves: %{
          move_average: :kick,
          move_heal: :guitar_jam,
          move_random: :roll_dice
        },
        name: "Pinho"
      }
      assert expected_response_player == Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
    end
  end
end
