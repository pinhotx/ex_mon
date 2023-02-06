defmodule ExMon.Player do

  @max_life 100
  @required_keys [:life, :moves, :name]

  @enforce_keys @required_keys
  defstruct @required_keys

  def build(name,  move_average, move_random, move_heal) do
      %ExMon.Player{
        life: @max_life,
        moves: %{
          move_average: move_average,
          move_heal: move_heal,
          move_random: move_random
        },
        name: name
      }
  end

end
