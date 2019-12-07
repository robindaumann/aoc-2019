defmodule IntcodeTestNew do
  use ExUnit.Case

  test "decode_instr" do
    assert Intcode.decode_instr(2) == [modes: [0, 0, 0], operation: &*/2, length: 4]
  end

  test "decode_instr mode" do
    assert Intcode.decode_instr(102) == [modes: [1, 0, 0], operation: &*/2, length: 4]
  end

  test "decode_instr modes" do
    assert Intcode.decode_instr(1002) == [modes: [0, 1, 0], operation: &*/2, length: 4]
  end

  test "decode_instr add modes" do
    assert Intcode.decode_instr(1001) == [modes: [0, 1, 0], operation: &+/2, length: 4]
  end

  test "decode_instr ouput" do
    assert Intcode.decode_instr(3) == [modes: [0], operation: &IO.read/2, length: 2]
  end
end
