defmodule IntcodeTest do
  use ExUnit.Case, async: true

  test "read" do
    assert Intcode.read("1,2,3,4") == [1,2,3,4]
  end

  test "decode" do
    params = [1,2,3]
    assert Intcode.decode([2 | params]) == %{params: params, modes: [0,0,0], operation: :mult, length: 4}
  end

  test "decode mode" do
    params = [9,8,12]
    assert Intcode.decode([102 | params]) == %{params: params, modes: [1,0,0], operation: :mult, length: 4}
  end

  test "decode modes" do
    params = [3,3,3]
    assert Intcode.decode([1102 | params]) == %{params: params, modes: [1,1,0], operation: :mult, length: 4}
  end

  test "decode add mode" do
    params = [0,0,0]
    assert Intcode.decode([10001 | params]) == %{params: params, modes: [0, 0, 1], operation: :add, length: 4}
  end

  test "decode input" do
    assert Intcode.decode([3, 1]) == %{params: [1], modes: [0], operation: :read, length: 2}
  end

  test "decode jump true" do
    assert Intcode.decode([5, 1, 9]) == %{params: [1,9], modes: [0,0], operation: :jump_true, length: 3}
  end

  test "decode jump false" do
    assert Intcode.decode([106, -3, 5]) == %{params: [-3,5], modes: [1,0], operation: :jump_false, length: 3}
  end

  test "decode lt" do
    assert Intcode.decode([1107, -7, -5, 1]) == %{params: [-7,-5,1], modes: [1,1,0], operation: :lt, length: 4}
  end

  test "decode equals" do
    assert Intcode.decode([8, 11, 11, 11]) == %{params: [11,11,11], modes: [0,0,0], operation: :equals, length: 4}
  end

  test "load params" do
    params = [{7,1}, {0,0}]
    assert Intcode.load_params(params, [99]) == [7, 99]
  end

  test "step add" do
    list = [1,0,0,0,99]
    assert Intcode.step(list, 0) == [2,0,0,0,99]
  end

  test "step multiply" do
    list = [2,3,0,3,99]
    assert Intcode.step(list, 0) == [2,3,0,6,99]
  end

  test "step value after 99" do
    list = [2,4,4,5,99,0]
    assert Intcode.step(list, 0) == [2,4,4,5,99,9801]
  end

  test "step modify termination" do
    list = [1,1,1,4,99,5,6,0,99]
    assert Intcode.step(list, 0) == [30,1,1,4,2,5,6,0,99]
  end
end
