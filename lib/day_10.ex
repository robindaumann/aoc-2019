defmodule Day10 do
  def part1(path) do
    File.stream!(path) |> max_reachable()
  end

  def part2(path) do

  end

  def spin(grid, pos) do

    reachable(grid, pos)
  end

  def remove(grid, points) do
    grid -- points
  end

  def angle({x,y}) do
    # {x_ref, y_ref} = {0, -1}
    dot_prod = -y
    len = :math.sqrt(x*x + y*y)
    :math.acos(dot_prod/len) * 180/:math.pi
  end

  def max_reachable(lines) do
    grid = parse(lines)

    grid
    |> Stream.map(fn point -> {point, reachable(grid, point) |> Enum.count()} end)
    |> Enum.max_by(&elem(&1, 1))
  end

  def reachable(grid, pos) do
    grid = grid -- [pos]
    lines = lines(grid, pos)

    grid
    |> Stream.reject(&any_covered?(&1, lines))
  end

  def lines(grid, pos), do: for star <- grid, do: line(pos, star)

  def line({ax, ay} = a, {bx, by}) do
    d = {bx-ax, by-ay}
    %{a: a, d: d}
  end

  def any_covered?(point, lines) do
    Enum.any?(lines, &covered?(&1, point))
  end

  def covered?(%{d: {0, 0}}, _), do: false

  def covered?(%{a: {ax, ay}, d: {0, dy}}, {px, py}) do
    px == ax && λ(ay, dy, py) > 1
  end

  def covered?(%{a: {ax, ay}, d: {dx, 0}}, {px, py}) do
    py == ay && λ(ax, dx, px) > 1
  end

  def covered?(%{a: {ax, ay}, d: {dx, dy}}, {px, py}) do
    λx = λ(ax, dx, px)
    λy = λ(ay, dy, py)

    λx == λy && λx > 1 && λy > 1
  end

  def λ(a, d, p) when d != 0 do
    # a + λ * dir = p
    # λ = (p - a) / dir
    (p - a) / d
  end

  def parse(lines) do
    lines
    |> Enum.with_index()
    |> Enum.reduce([], fn {line, y}, acc -> acc ++ parse(line, y) end)
  end

  def parse(line, y) do
    String.codepoints(line)
    |> Enum.with_index()
    |> Enum.filter(fn {e, _} -> e == "#" end)
    |> Enum.map(fn {_, x} -> {x,y} end)
  end
end
