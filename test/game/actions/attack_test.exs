defmodule ExMon.Game.Actions.AttackTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}
  alias ExMon.Game.Actions.Attack
  import ExUnit.CaptureIO

  describe "attack_opponent/2" do
    setup do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "the player attacks the opponent" do
      message = capture_io(fn ->
        assert Attack.attack_opponent(:computer, :move_average) == :ok
      end)
      assert message =~ "Your attack dealt"
    end

    test "the computer attacks the opponent" do
      message = capture_io(fn ->
        Game.info()
        |> Map.put(:turn, :player)
        |> Game.update()

        assert Attack.attack_opponent(:player, :move_average) == :ok

        :ok
      end)
      assert message =~ "The Computer dealt"
    end
  end
end
