defmodule Day12 do
  def part1(path) do
    File.stream!(path) |> simulate_steps(1000)
  end

  def part2(path) do
    File.stream!(path) |> find_cycle()
  end

  def find_cycle(lines) do
    moons = parse(lines)

    0..2
    |> Enum.map(fn dir ->
      target = direction(moons, dir)
      find_period(moons, dir, target, 1)
    end)
    |> lcm()
  end

  def find_period(moons, dir, target, i) do
    moons = step(moons)

    case direction(moons, dir) do
      ^target -> i
      _ -> find_period(moons, dir, target, i+1)
    end
  end

  def direction(moons, dir) do
    Enum.reduce(moons, %{vel: [], pos: []}, &direction(&1, &2, dir))
  end

  def direction(%{pos: pos, vel: vel}, acc, dir) do
    p = Enum.at(pos, dir)
    v = Enum.at(vel, dir)

    acc = Map.update!(acc, :vel, fn list -> [v | list] end)
    acc = Map.update!(acc, :pos, fn list -> [p | list] end)

    acc
  end

  def simulate_steps(lines, steps) do
    moons = parse(lines)

    1..steps
    |> Enum.reduce(moons, fn _, acc -> step(acc) end)
    |> energy()
  end

  defp step(moons) do
    moons
    |> Enum.map(&velocity(&1, moons))
    |> Enum.map(&position/1)
  end

  def energy(moons) do
    moons
    |> Enum.map(fn %{pos: pos, vel: vel} ->
      abs_sum(pos) * abs_sum(vel)
    end)
    |> Enum.sum()
  end

  def position(%{pos: pos, vel: vel} = moon) do
    pos = add_xyz(pos,vel)

    %{moon | pos: pos }
  end

  def velocity(%{pos: pos, vel: vel} = moon, moons) do
    vel = moons
    |> Enum.map(&Map.fetch!(&1, :pos))
    |> Enum.map(&cmp_xyz(&1, pos))
    |> Enum.reduce(vel, &add_xyz/2)

    %{moon | vel: vel}
  end

  def parse(lines) do
    Enum.map(lines, &parse_line/1)
  end

  def parse_line(line) do
    ~r/<x=(-?\d+), y=(-?\d+), z=(-?\d+)>/
    |> Regex.run(line)
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer/1)
    |> pack()
  end

  defp pack(pos), do: %{pos: pos, vel: [0,0,0]}

  defp lcm(n), do: Enum.reduce(n, fn x, acc -> div((x*acc), Integer.gcd(x,acc)) end)

  defp abs_sum(xyz), do: Enum.map(xyz, &abs/1) |> Enum.sum()

  defp cmp_xyz(m1,m2), do: zip_map(m1, m2, &cmp/1)

  defp add_xyz(m1, m2), do: zip_map(m1, m2, &add/1)

  defp zip_map(x,y, op), do: Enum.zip(x,y) |> Enum.map(op)

  defp cmp({x,y}) when x == y, do: 0
  defp cmp({x,y}) when x > y, do: 1
  defp cmp({x,y}) when x < y, do: -1

  defp add({x,y}), do: x+y
end
