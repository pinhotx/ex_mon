defmodule ExMon.Game.Status do

  def print_round_message(%{status: :started} = info) do
    build_round_message(:started)
    IO.inspect(info)
    IO.puts("\n ------------------------")
  end

  def print_round_message(%{status: status, turn: turn} = info) do
    build_round_message(status, turn)
    IO.inspect(info)
    IO.puts("\n ------------------------")
  end

  def build_round_message(:started), do: IO.puts("\n The Game has Started")
  def build_round_message(:game_over, :player), do: IO.puts("\n You Won")
  def build_round_message(:game_over, :computer), do: IO.puts("\n You Lost")
  def build_round_message(:continue, :computer), do: IO.puts("\n Defend yourself, It's computer's turn")
  def build_round_message(:continue, :player), do: IO.puts("\n It's your Turn")

  def print_wrong_move_message(move) do
    IO.puts("\n - - - - Invalid Move #{move} - - - -")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n - - - - Your attack dealt #{damage} on Computer - - - -")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n - - - - The Computer dealt #{damage} on you - - - -")
  end

  def print_move_message(:computer, :heal, life) do
    IO.puts("\n - - -  The Computer restored itself to #{life} HP - - - -")
  end

  def print_move_message(:player, :heal, life) do
    IO.puts("\n - - - - You restored to #{life} HP - - - -")
  end
end
