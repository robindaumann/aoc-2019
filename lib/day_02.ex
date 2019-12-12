defmodule Day02 do
  def part1(path) do
    path
    |> Intcode.read_path()
    |> solve(12, 2)
  end

  def part2(path) do
    mem = Intcode.read_path(path)
    inputs = for i <- 0..99, j <- 0..99, do: {i,j}

    inputs
    |> Stream.map(fn {i, j} -> {solve(mem, i, j), 100*i + j} end)
    |> Enum.find(fn ({res, _}) -> res == 19690720 end)
    |> elem(1)
  end

  defp solve(memory, r1, r2) do
    memory
    |> List.replace_at(1, r1)
    |> List.replace_at(2, r2)
    |> Intcode.run
  end
end
