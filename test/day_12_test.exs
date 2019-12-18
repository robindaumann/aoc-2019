defmodule Day12Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    path = Input.path()
    assert Day12.part1(path) == 8044
  end

  test "part2 input" do
    path = Input.path()
    assert Day12.part2(path) == 362375881472136
  end

  test "part1 example" do
    lines = lines(example1())
    assert Day12.simulate_steps(lines, 10) == 179
  end

  test "part1 example2" do
    lines = lines(example2())
    assert Day12.simulate_steps(lines, 100) == 1940
  end

  test "part2 example" do
    lines = lines(example1())
    assert Day12.find_cycle(lines) == 2772
  end

  test "part2 example2" do
    lines = lines(example2())
    assert Day12.find_cycle(lines) == 4686774924
  end

  test "parse line" do
    assert Day12.parse_line("<x=0, y=5, z=-5>") == %{pos: [0, 5, -5], vel: [0, 0, 0]}
  end

  test "energy" do
    moon = %{pos: [1, 2, 3], vel: [-9, -8, -7]}

    assert Day12.energy([moon]) == (1+2+3)*(9+8+7)
  end

  def example1() do
    """
    <x=-1, y=0, z=2>
    <x=2, y=-10, z=-7>
    <x=4, y=-8, z=8>
    <x=3, y=5, z=-1>
    """
  end

  def example2() do
    """
    <x=-8, y=-10, z=0>
    <x=5, y=5, z=10>
    <x=2, y=-7, z=3>
    <x=9, y=-8, z=-3>
    """
  end

  def lines(s), do: String.split(s, "\n") |> Enum.drop(-1)
end
