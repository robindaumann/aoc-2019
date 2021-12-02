defmodule Day10Test do
  use ExUnit.Case, async: true
  require Input

  test "part1" do
    path = Input.path()
    assert Day10.part1(path) == {{25, 31}, 329}
  end

  test "part1 example" do
    assert example1() |> Day10.max_reachable() == {{3, 4}, 8}
  end

  test "part1 large example" do
    assert example2() |> Day10.max_reachable() == {{11, 13}, 210}
  end

  test "angle" do
    assert Day10.angle({0, -2}) == 0
  end

  test "angle 90" do
    assert Day10.angle({1, 0}) == 90
  end

  test "angle 180" do
    assert Day10.angle({0, 1}) == 180
  end

  test "line" do
    a = {1,1}
    b = {2,1}

    assert Day10.line(a, b) == %{a: {1,1}, d: {1,0}}
  end

  test "covered?" do
    line = %{a: {0,0}, d: {1,1}}
    p = {3,3}

    assert Day10.covered?(line, p)
  end

  test "cotains? dx zero" do
    line = %{a: {0,0}, d: {0,1}}
    p = {0, 7}

    assert Day10.covered?(line, p)
  end

  test "not covered? in front" do
    line = %{a: {1,0}, d: {2,2}}
    p = {2,1}

    refute Day10.covered?(line, p)
  end

  test "not covered?" do
    line = %{a: {0,0}, d: {1,1}}
    p = {2,3}

    refute Day10.covered?(line, p)
  end

  test "parse lines" do
    s = example1()
    assert Day10.parse(s) == [
      {1,0}, {4,0}, {0,2}, {1,2}, {2,2}, {3,2}, {4,2}, {4,3}, {3,4}, {4,4}
    ]
  end

  test "parse line" do
    assert Day10.parse(".#..#", 0) == [{1,0}, {4,0}]
  end

  def example1() do
    """
    .#..#
    .....
    #####
    ....#
    ...##
    """
    |> String.split("\n")
  end

  def example2() do
    """
    .#..##.###...#######
    ##.############..##.
    .#.######.########.#
    .###.#######.####.#.
    #####.##.#.##.###.##
    ..#####..#.#########
    ####################
    #.####....###.#.#.##
    ##.#################
    #####.##.###..####..
    ..######..##.#######
    ####.##.####...##..#
    .#####..#.######.###
    ##...#.##########...
    #.##########.#######
    .####.#.###.###.#.##
    ....##.##.###..#####
    .#.#.###########.###
    #.#.#.#####.####.###
    ###.##.####.##.#..##
    """ |> String.split("\n")
  end
end
