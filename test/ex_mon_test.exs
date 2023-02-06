defmodule ExMonTest do
  use ExUnit.Case
  alias ExMon.Player

  import ExUnit.CaptureIO
alias ExMon.Player

 describe "create_player/4" do
  test "returns a player" do
    expected_response_player = %Player{
      life: 100,
      moves: %{
        move_average: :kick,
        move_heal: :guitar_jam,
        move_random: :roll_dice
      },
      name: "Pinho"
    }

    assert expected_response_player == ExMon.create_player("Pinho", :kick, :roll_dice, :guitar_jam)
  end

 end

 describe "start_game/1" do
  test "when the game is started, returns a message" do
    player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
    messages =
      capture_io(fn ->

      assert ExMon.start_game(player) == :ok

    end)
    assert messages =~ "The Game has Started"
    assert messages =~ "status: :started"
    assert messages =~ "turn: :player"

  end

 end

 describe "make_move/1" do
  setup do
    player = Player.build("Pinho", :kick, :roll_dice, :guitar_jam)
    capture_io(fn ->
      ExMon.start_game(player)
    end)

    :ok
  end
  test "when the move is valid, do move and computer also makes a move" do

    messages =
      capture_io(fn ->
        ExMon.make_move(:kick)
      end)

    assert messages =~ "It's computer's turn"
    assert messages =~ "It's your Turn"
    assert messages =~ "status: :continue"

  end

  test "when the move is invalid, returns an error message" do
    messages =
      capture_io(fn ->
        ExMon.make_move(:invalid_move)
      end)
    assert messages =~ "Invalid Move invalid_move"

  end

 end
end
