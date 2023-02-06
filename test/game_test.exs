defmodule ExMon.GameTest do

  @moduledoc """
    Automatic test made by Pinhotx
    Testing all public functions from ExMon.Game (game.ex)
  """

  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      computer = Player.build("Bad Pinho", :kick, :split_dice, :potion)

      assert {:ok, _pid} = Game.start(computer, player)

    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      computer = Player.build("Bad Pinho", :kick, :split_dice, :potion)
      Game.start(computer, player)

      expected_response = %{
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

      assert expected_response == Game.info()

    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      computer = Player.build("Bad Pinho", :kick, :split_dice, :potion)
      Game.start(computer, player)

      expected_response = %{
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

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 53,
          moves: %{
            move_average: :kick,
            move_heal: :potion,
            move_random: :split_dice
            },
          name: "Bad Pinho"
        },
        player: %Player{
          life: 88,
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

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()

    end
  end

  describe "player/0" do
    test "returns the player's info" do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      computer = Player.build("Bad Pinho", :kick, :split_dice, :potion)
      Game.start(computer, player)

      expected_game_info = %{
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

      assert expected_game_info == Game.info()

      expected_player_info = %Player{
        life: 100,
        moves: %{
          move_average: :kick,
          move_heal: :guitar_jam,
          move_random: :roll_dice
        },
        name: "Pinho"
      }

      assert Game.player() == expected_player_info
    end

  end

  describe "computer/0" do
    test "return the computer's info" do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      computer = Player.build("Bad Pinho", :kick, :split_dice, :potion)
      Game.start(computer, player)

      expected_game_info = %{
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

      assert expected_game_info == Game.info()

      expected_computer_info = %Player{
        life: 100,
        moves: %{
          move_average: :kick,
          move_heal: :potion,
          move_random: :split_dice
          },
        name: "Bad Pinho"
      }

      assert Game.computer() == expected_computer_info
    end

  end

  describe "turn/0" do
    test "return whose turn is" do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      computer = Player.build("Bad Pinho", :kick, :split_dice, :potion)
      Game.start(computer, player)

      expected_game_info = %{
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

      assert expected_game_info == Game.info()

      expected_turn = :player

      assert Game.turn() == expected_turn
    end

  end

  describe "fetch_player/1" do
    test "return a determined player info" do
      player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
      computer = Player.build("Bad Pinho", :kick, :split_dice, :potion)
      Game.start(computer, player)

      expected_game_info = %{
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

      assert expected_game_info == Game.info()

      expected_player_info = %Player{
        life: 100,
        moves: %{
          move_average: :kick,
          move_heal: :potion,
          move_random: :split_dice
          },
        name: "Bad Pinho"
      }

      assert Game.fetch_player(:computer) == expected_player_info
    end

  end

end
