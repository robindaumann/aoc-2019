defmodule Day03 do
  def part1(path) do
    path
    |> File.stream!
    |> solve1
  end

  def part2(path) do
    path
    |> File.stream!
    |> solve2
  end

  def solve2(lines) do
    traces = Enum.map(lines, &generate_trace/1)

    intersect(traces)
    |> Enum.map(&trace_length(&1, traces))
    |> Enum.min
  end

  def solve1(lines) do
    lines
    |> Enum.map(&generate_trace/1)
    |> intersect
    |> min_distance
  end

  defp trace_length(point, traces) do
      sum = traces
      |> Enum.map(&Enum.find_index(&1, fn x -> x == point end))
      |> Enum.sum

      # add two because we summed indices instead of sizes
      sum + 2
  end

  defp min_distance(points) do
    points
    |> Enum.map(fn {x,y} -> abs(x) + abs(y) end)
    |> Enum.min
  end

  defp intersect(traces) do
    [t1, t2] = Enum.map(traces,&MapSet.new/1)

    MapSet.intersection(t1, t2)
  end

  def generate_trace(line) do
    line
    |> String.split(",")
    |> Enum.map(&Regex.run(~r/^(U|D|L|R)(\d+)$/, &1, capture: :all_but_first))
    |> Enum.map(fn [dir, count] -> [dir, String.to_integer(count)] end)
    |> trace({0,0})
  end

  def trace([], _) do
    []
  end

  def trace([dir | rest], point) do
    points = points(dir, point)
    points ++ trace(rest, List.last(points))
  end

  def points([_, c], _) when c < 1, do: []

  def points(["U", c], {x,y}) do
    for c <- 1..c, do: {x, y+c}
  end

  def points(["D", c], {x,y}) do
    for c <- 1..c, do: {x, y-c}
  end

  def points(["L", c], {x,y}) do
    for c <- 1..c, do: {x-c, y}
  end

  def points(["R", c], {x,y}) do
    for c <- 1..c, do: {x+c, y}
  end
end
