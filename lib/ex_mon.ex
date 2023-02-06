defmodule ExMon do

  @moduledoc """
  Documentation for `ExMon`.
  """

  @doc """


  ## Examples

      iex> ExMon.create_player("Pinho", :kick, :roll_dice, :guitar_jam)
      %ExMon.Player{
        life: 100,
        move_average: :kick,
        move_heal: :guitar_jam,
        move_random: :roll_dice,
        name: "Pinho"
      }

  """

  alias ExMon.{Game, Player} # , as: Jogador
  alias ExMon.Game.{Actions, Status}

  @computer_name "Bad Pinho"
  @computer_moves [:move_average, :move_random, :move_heal]

  def create_player(name, move_average, move_random, move_heal) do
    Player.build(name, move_average, move_random, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:kick, :split_dice, :potion)
    |> Game.start(player)
    Status.print_round_message(Game.info)
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())
  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)
  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal
        #"Healing"
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info)
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end

  defp computer_move(_), do: :ok

end
