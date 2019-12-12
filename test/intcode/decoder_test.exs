defmodule Intcode.DecoderTest do
  use ExUnit.Case, async: true
  alias Intcode.Decoder

  test "decode" do
    params = [1,2,3]
    expect = %{length: 4, operation: :mult, params: [{1, 0, :in}, {2, 0, :in}, {3, 0, :out}]}
    assert Decoder.decode([2 | params]) == expect
  end

  test "decode mode" do
    params = [9,8,12]
    expect = %{length: 4, operation: :mult, params: [{9, 1, :in}, {8, 0, :in}, {12, 0, :out}]}
    assert Decoder.decode([102 | params]) == expect
  end

  test "decode modes" do
    params = [3,3,3]
    expect = %{length: 4, operation: :mult, params: [{3, 1, :in}, {3, 1, :in}, {3, 0, :out}]}
    assert Decoder.decode([1102 | params]) == expect
  end

  test "decode add mode" do
    params = [0,0,0]
    expect = %{length: 4, operation: :add, params: [{0, 0, :in}, {0, 0, :in}, {0, 1, :out}]}
    assert Decoder.decode([10001 | params]) == expect
  end

  test "decode input" do
    expect = %{length: 2, operation: :read, params: [{1, 0, :out}]}
    assert Decoder.decode([3, 1]) == expect
  end

  test "decode jump true" do
    expect = %{length: 3, operation: :jump_true, params: [{1, 0, :in}, {9, 0, :in}]}
    assert Decoder.decode([5, 1, 9]) == expect
  end

  test "decode jump false" do
    expect = %{length: 3, operation: :jump_false, params: [{-3, 1, :in}, {5, 0, :in}]}
    assert Decoder.decode([106, -3, 5]) == expect
  end

  test "decode lt" do
    expect = %{length: 4, operation: :lt, params: [{-7, 1, :in}, {-5, 1, :in}, {1, 0, :out}]}
    assert Decoder.decode([1107, -7, -5, 1]) == expect
  end

  test "decode equals" do
    expect = %{length: 4, operation: :equals, params: [{11, 0, :in}, {11, 0, :in}, {11, 0, :out}]}
    assert Decoder.decode([8, 11, 11, 11]) == expect
  end
end
