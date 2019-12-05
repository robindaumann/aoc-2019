defmodule IntcodeTest do
  use ExUnit.Case

  test "read" do
    assert Intcode.read("1,2,3,4") == [1,2,3,4]
  end

  test "decode add" do
    list = [1,0,0,0]
    assert Intcode.decode(list, list) == {:cont, [2,0,0,0]}
  end

  test "decode multiply" do
    list = [2,0,0,0]
    assert Intcode.decode(list, list) == {:cont, [4,0,0,0]}
  end

  test "decode halt" do
    list = [99,0,0,0]
    assert Intcode.decode(list, list) == {:halt, [99,0,0,0]}
  end

  test "example 1" do
    list = [1,0,0,0,99]
    assert Intcode.step(list, 0) == [2,0,0,0,99]
  end

  test "example 2" do
    list = [2,3,0,3,99]
    assert Intcode.step(list, 0) == [2,3,0,6,99]
  end

  test "example 3" do
    list = [2,4,4,5,99,0]
    assert Intcode.step(list, 0) == [2,4,4,5,99,9801]
  end

  test "example 4" do
    list = [1,1,1,4,99,5,6,0,99]
    assert Intcode.step(list, 0) == [30,1,1,4,2,5,6,0,99]
  end
end
