defmodule ExMon.Game.Actions.HealTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}
  alias ExMon.Game.Actions.Heal
  import ExUnit.CaptureIO

  describe "attack_opponent/2" do
    setup do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      capture_io(fn ->
        ExMon.start_game(player)
      end)
      new_state = %{
        computer: %Player{
          life: 80,
          moves: %{
            move_average: :kick,
            move_heal: :potion,
            move_random: :split_dice
            },
          name: "Bad Pinho"
        },
        player: %Player{
          life: 80,
          moves: %{
            move_average: :kick,
            move_heal: :guitar_jam,
            move_random: :roll_dice
          },
          name: "Pinho"
        },
        status: :started,
        turn: :computer
      }
      Game.update(new_state)

      :ok
    end

    test "the player heals itself" do
      message = capture_io(fn ->
        assert Heal.heal_life(:player) == :ok
      end)
      assert message =~ "You restored to"
    end

    test "the computer heals itself" do
      message = capture_io(fn ->
        Game.info()
        |> Map.put(:turn, :player)
        |> Game.update()

        assert Heal.heal_life(:computer) == :ok

        :ok
      end)
      assert message =~ "The Computer restored itself"
    end
  end
end
