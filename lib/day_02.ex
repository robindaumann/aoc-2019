defmodule Day02 do
  def part1(path) do
    path
    |> read()
    |> solve(12, 2)
  end

  def part2(path) do
    mem = read(path)
    inputs = for i <- 0..99, j <- 0..99, do: {i,j}

    inputs
    |> Enum.map(fn {i, j} -> {solve(mem, i, j), 100*i + j} end)
    |> Enum.find(fn ({res, _}) -> res == 19690720 end)
    |> elem(1)
  end

  defp read(path) do
    path
    |> File.read!
    |> Intcode.read
  end

  defp solve(memory, r1, r2) do
    memory
    |> List.replace_at(1, r1)
    |> List.replace_at(2, r2)
    |> Intcode.run
  end
end
