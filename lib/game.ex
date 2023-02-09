defmodule ExMon.Game do
  alias ExMon.Player
  use Agent

  def start(computer, player) do
    turn = toss_a_coin(:player, :computer)
    initial_value =
      %{
        computer: computer,
        player: player,
        turn: turn,
        status: :started,
        #last_skill: nil
    }
    # Inicia o estado do jogo com o valor inicial e o nome do modulo
    start_link = Agent.start_link(fn -> initial_value end, name: __MODULE__)
    handle_first_turn(turn)

    start_link
  end

  # Retorna informações sobre o estado
  def info do
    Agent.get(__MODULE__, & &1)
  end

  def update(state) do
    Agent.update(__MODULE__, fn _ -> update_game_status(state) end)
  end

  def computer, do: fetch_player(:computer)
  def player, do: fetch_player(:player)
  def fetch_player(player), do: Map.get(info(), player)

  def turn, do: Map.get(info(), :turn)

  defp update_game_status(
    %{
      player: %Player{life: player_life},
      computer: %Player{life: computer_life}
    } = state )
  when player_life == 0 or computer_life == 0, do: Map.put(state, :status, :game_over)

  defp update_game_status(state) do
    state
    |> Map.put(:status, :continue)
    |> update_turn()
  end

  defp update_turn(%{turn: :player} = state), do: Map.put(state, :turn, :computer)
  defp update_turn(%{turn: :computer} = state), do: Map.put(state, :turn, :player)

  defp handle_first_turn(:computer) do
    ExMon.make_move
  end

  defp handle_first_turn(:player), do: :ok

  defp toss_a_coin(head, tails), do: Enum.random([head, tails])
end
