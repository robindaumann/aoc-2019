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
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp solve(memory, r1, r2) do
    memory
    |> List.replace_at(1, r1)
    |> List.replace_at(2, r2)
    |> step(0)
    |> Enum.at(0)
  end

  def step(list, index) do
    slice = Enum.slice(list, index..index+3)
    case decode(slice, list) do
      {:cont, list} -> step(list, index+4)
      {:halt, list} -> list
    end
  end

  def decode([1, s1, s2, d], list) do
    execute(list, &+/2, s1, s2, d)
  end

  def decode([2, s1, s2, d], list) do
    execute(list, &*/2, s1, s2, d)
  end

  def decode([99 | _], list) do
    {:halt, list}
  end

  defp execute(list, f, s1, s2, d) do
    res = f.(Enum.at(list, s1), Enum.at(list, s2))
    list = List.replace_at(list, d, res)
    {:cont, list}
  end
end
