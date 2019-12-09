defmodule Day08 do
  def part1(dev, width, height) do
    layers = parse(dev, width, height)

    idx = min_zeros(layers)
    Enum.at(layers, idx) |> checksum
  end

  def part2(dev, width, height) do
    parse(dev, width, height)
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&overlap_all/1)
    |> Enum.chunk_every(width)
  end

  def show(l) do
    Enum.map_join(l, "\n", &Enum.map_join(&1, "", fn
      0 -> " "
      1 -> "#"
      end))
  end

  def overlap_all(list) do
    List.foldl(list, 2, &overlap/2)
  end

  def overlap(x, 2), do: x
  def overlap(_, x), do: x

  defp parse(dev, width, height) do
    size = width * height
    dev
    |> IO.read(:all)
    |> layers(size)
  end

  def layers(s, size) do
    s
    |> String.trim
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(size)
  end

  def checksum(layer) do
    ones = count(layer, 1)
    zwos = count(layer, 2)
    ones * zwos
  end

  def min_zeros(layers) do
    counts = Enum.map(layers, &count(&1, 0))
    min = Enum.min(counts)

    Enum.find_index(counts, &(&1 == min))
  end

  def count(enum, num) do
    Enum.count(enum, fn x -> x == num end)
  end
end
