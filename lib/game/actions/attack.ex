defmodule ExMon.Game.Actions.Attack do

  # TODO: Calculate damage using a Base Power and Dices
  alias ExMon.Game
  alias ExMon.Game.Status
  # @move_base_power 10

  @move_average_power 12..15
  @move_random_power 1..20

  # def roll_dice(:d20), do: Enum.random(1..20)
  # def roll_dice(:d6), do: Enum.random(1..20)
  # def roll_dice(:d4), do: Enum.random(1..20)

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)
    opponent
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_opponent_life(opponent, damage)

  end

  defp calculate_power(:move_average), do: Enum.random(@move_average_power)
  defp calculate_power(:move_random), do: Enum.random(@move_random_power)

  defp calculate_total_life(life, damage) when life - damage < 0, do: 0
  defp calculate_total_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(opponent, damage)
  end

  defp update_game(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end

end
