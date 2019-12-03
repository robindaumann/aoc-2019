defmodule Day01 do
  def part1(path), do: solve(path, &fuel/1)

  def part2(path), do: solve(path, &fuel_rec/1)

  defp solve(path, f) do
    path
    |> File.stream!
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(f)
    |> Enum.sum
  end

  @spec fuel(integer) :: integer
  def fuel(mass), do: div(mass, 3) - 2

  @spec fuel_rec(integer) :: integer
  def fuel_rec(mass) when div(mass, 3) - 2 > 0 do
    fuel = fuel(mass)
    fuel + fuel_rec(fuel)
  end

  def fuel_rec(_), do: 0
end
