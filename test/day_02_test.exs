defmodule Day02Test do
  use ExUnit.Case
  require Input

  test "part1 input" do
    f = Input.path()
    assert Day02.part1(f) == 6627023
  end

  test "part2 input" do
    f = Input.path()
    assert Day02.part2(f) == 4019
  end
end
