defmodule IntcodeTestNew do
  use ExUnit.Case

  test "decode" do
    parms = [1,2,3]
    assert Intcode.decode([2 | parms]) == %{parms: parms, modes: [0,0,0], operation: :mult, length: 4}
  end

  test "decode mode" do
    parms = [9,8,12]
    assert Intcode.decode([102 | parms]) == %{parms: parms, modes: [1,0,0], operation: :mult, length: 4}
  end

  test "decode modes" do
    parms = [3,3,3]
    assert Intcode.decode([1102 | parms]) == %{parms: parms, modes: [1,1,0], operation: :mult, length: 4}
  end

  test "decode add mode" do
    parms = [0,0,0]
    assert Intcode.decode([10001 | parms]) == %{parms: parms, modes: [0, 0, 1], operation: :add, length: 4}
  end

  test "decode input" do
    assert Intcode.decode([3, 1]) == %{parms: [1], modes: [0], operation: :read, length: 2}
  end
end
