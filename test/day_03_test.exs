defmodule Day03Test do
  use ExUnit.Case, async: true
  require Input

  @example1 ["R8,U5,L5,D3", "U7,R6,D4,L4"]
  @example2 ["R75,D30,R83,U83,L12,D49,R71,U7,L72",
  "U62,R66,U55,R34,D71,R55,D58,R83"]
  @example3 ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
  "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]

  test "part1 input" do
    f = Input.path()
    assert Day03.part1(f) == 2180
  end

  test "part2 input" do
    f = Input.path()
    assert Day03.part2(f) == 112316
  end

  test "example 1 part 2" do
    assert Day03.solve2(@example1) == 30
  end

  test "example 2 part 2" do
    assert Day03.solve2(@example2) == 610
  end

  test "example 3 part 2" do
    assert Day03.solve2(@example3) == 410
  end

  test "example 1" do
    assert Day03.solve1(@example1) == 6
  end

  test "example 2" do
    assert Day03.solve1(@example2) == 159
  end

  test "example 3" do
    assert Day03.solve1(@example3) == 135
  end

  test "generate_trace small" do
    input = "R1,U2"
    assert Day03.generate_trace(input) == [{1, 0}, {1, 1}, {1, 2}]
  end

  test "points up" do
    assert Day03.points(["U", 2], {1, 0}) == [{1, 1}, {1, 2}]
  end

  test "points down" do
    assert Day03.points(["D", 1], {0, 0}) == [{0, -1}]
  end

  test "points left" do
    assert Day03.points(["L", 3], {99, 99}) == [{98, 99}, {97, 99}, {96, 99}]
  end

  test "points right" do
    assert Day03.points(["R", 1], {-7, 12}) == [{-6, 12}]
  end

  test "points zero" do
    assert Day03.points(["R", 0], {0, 0}) == []
  end

  test "points negative" do
    assert Day03.points(["U", -545], {-7, -444}) == []
  end
end
