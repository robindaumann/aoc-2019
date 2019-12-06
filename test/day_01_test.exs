defmodule Day01Test do
  use ExUnit.Case, async: true
  require Input

  test "Mass 12" do
    assert Day01.fuel(12) == 2
  end

  test "Mass 14" do
    assert Day01.fuel(14) == 2
  end

  test "Mass 1969" do
    assert Day01.fuel(1969) == 654
  end

  test "Mass 100756" do
    assert Day01.fuel(100756) == 33583
  end

  test "part1 input" do
    f = Input.path()
    assert Day01.part1(f) == 3305115
  end

  test "Mass 14 rec" do
    assert Day01.fuel_rec(14) == 2
  end

  test "Mass 1969 rec" do
    assert Day01.fuel_rec(1969) == 966
  end

  test "Mass 100756 rec" do
    assert Day01.fuel_rec(100756) == 50346
  end

  test "part2 input" do
    f = Input.path()
    assert Day01.part2(f) == 4954799
  end
end
