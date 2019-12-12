defmodule Intcode.DecoderTest do
  use ExUnit.Case, async: true
  alias Intcode.Decoder

  test "decode" do
    params = [1,2,3]
    assert Decoder.decode([2 | params]) == %{params: params, modes: [0,0,0], operation: :mult, length: 4}
  end

  test "decode mode" do
    params = [9,8,12]
    assert Decoder.decode([102 | params]) == %{params: params, modes: [1,0,0], operation: :mult, length: 4}
  end

  test "decode modes" do
    params = [3,3,3]
    assert Decoder.decode([1102 | params]) == %{params: params, modes: [1,1,0], operation: :mult, length: 4}
  end

  test "decode add mode" do
    params = [0,0,0]
    assert Decoder.decode([10001 | params]) == %{params: params, modes: [0, 0, 1], operation: :add, length: 4}
  end

  test "decode input" do
    assert Decoder.decode([3, 1]) == %{params: [1], modes: [0], operation: :read, length: 2}
  end

  test "decode jump true" do
    assert Decoder.decode([5, 1, 9]) == %{params: [1,9], modes: [0,0], operation: :jump_true, length: 3}
  end

  test "decode jump false" do
    assert Decoder.decode([106, -3, 5]) == %{params: [-3,5], modes: [1,0], operation: :jump_false, length: 3}
  end

  test "decode lt" do
    assert Decoder.decode([1107, -7, -5, 1]) == %{params: [-7,-5,1], modes: [1,1,0], operation: :lt, length: 4}
  end

  test "decode equals" do
    assert Decoder.decode([8, 11, 11, 11]) == %{params: [11,11,11], modes: [0,0,0], operation: :equals, length: 4}
  end
end
