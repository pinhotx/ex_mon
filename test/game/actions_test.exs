defmodule ExMon.Game.ActionsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Game, Player}
  alias ExMon.Game.Actions

  describe "fetch_move/1" do
    setup do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, returns :ok and what kind of move it is " do
      move = :kick
      expected_response_move = {:ok, :move_average}

      assert expected_response_move == Actions.fetch_move(move)
    end

    test "when the move is invalid, returns :error and the name it move" do
      move = :punch
      expected_response_move = {:error, :punch}

      assert expected_response_move == Actions.fetch_move(move)
    end

  end

  describe "attack/1" do
    setup do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "the player attacks the opponent using an average damage move" do
      message =
        capture_io(fn ->
          Actions.attack(:move_average)

        end)
      assert message =~ "Your attack dealt"
      assert message =~ "on Computer"

    end

    test "the player attacks the opponent using an widely random damage move" do
      message =
        capture_io(fn ->
          Actions.attack(:move_random)

        end)
        assert message =~ "Your attack dealt"
        assert message =~ "on Computer"
    end

    test "computer attacks the player using an average damage move" do
      message =
        capture_io(fn ->
          new_state = %{
            computer: %Player{
              life: 100,
              moves: %{
                move_average: :kick,
                move_heal: :potion,
                move_random: :split_dice
                },
              name: "Bad Pinho"
            },
            player: %Player{
              life: 100,
              moves: %{
                move_average: :kick,
                move_heal: :guitar_jam,
                move_random: :roll_dice
              },
              name: "Pinho"
            },
            status: :started,
            turn: :player
          }
          Game.update(new_state)
          # Computer's Attack
          Actions.attack(:move_random)

        end)
      assert message =~ "The Computer dealt"
      assert message =~ "on you"

    end

    test "computer attacks the player using an widely random damage move" do
      message =
        capture_io(fn ->
          new_state = %{
            computer: %Player{
              life: 100,
              moves: %{
                move_average: :kick,
                move_heal: :potion,
                move_random: :split_dice
                },
              name: "Bad Pinho"
            },
            player: %Player{
              life: 100,
              moves: %{
                move_average: :kick,
                move_heal: :guitar_jam,
                move_random: :roll_dice
              },
              name: "Pinho"
            },
            status: :started,
            turn: :player
          }
          Game.update(new_state)
          # Computer's Attack
          Actions.attack(:move_random)
        end)
      assert message =~ "The Computer dealt"
      assert message =~ "on you"

    end
  end

  describe "heal/0" do
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

    test "the player heals itself and update game" do
      damaged_player_life =
        Game.player()
        |> Map.get(:life)

        heal_message =
          capture_io(fn ->
            Actions.heal
          end)

      new_life =
        Game.player()
        |> Map.get(:life)

      assert heal_message =~ "You restored to"
      assert new_life > damaged_player_life
    end

    test "the computer heals itself and update game" do

      damaged_computer_life =
        Game.computer()
        |> Map.get(:life)

      Game.info()
      |> Map.put(:turn, :player)
      |> Game.update()

      heal_message =
        capture_io(fn ->
          Actions.heal
        end)

      new_life =
        Game.computer()
        |> Map.get(:life)

      assert heal_message =~ "The Computer restored itself"
      assert new_life > damaged_computer_life

    end
  end
end
