defmodule Day02Test do
  use ExUnit.Case
  require Input

  test "decode add" do
    list = [1,0,0,0]
    assert Day02.decode(list, list) == {:cont, [2,0,0,0]}
  end

  test "decode multiply" do
    list = [2,0,0,0]
    assert Day02.decode(list, list) == {:cont, [4,0,0,0]}
  end

  test "decode halt" do
    list = [99,0,0,0]
    assert Day02.decode(list, list) == {:halt, [99,0,0,0]}
  end

  test "example 1" do
    list = [1,0,0,0,99]
    assert Day02.step(list, 0) == [2,0,0,0,99]
  end

  test "example 2" do
    list = [2,3,0,3,99]
    assert Day02.step(list, 0) == [2,3,0,6,99]
  end

  test "example 3" do
    list = [2,4,4,5,99,0]
    assert Day02.step(list, 0) == [2,4,4,5,99,9801]
  end

  test "example 4" do
    list = [1,1,1,4,99,5,6,0,99]
    assert Day02.step(list, 0) == [30,1,1,4,2,5,6,0,99]
  end

  test "part1 input" do
    f = Input.path()
    assert Day02.part1(f) == 6627023
  end

  test "part2 input" do
    f = Input.path()
    assert Day02.part2(f) == 4019
  end
end
