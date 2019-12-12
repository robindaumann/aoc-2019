defmodule IntcodeTest do
  use ExUnit.Case, async: true
  alias Intcode.Shared

  test "read" do
    assert Intcode.read("1,2,3,4") == [1,2,3,4]
  end

  test "step add" do
    list = [1,0,0,0,99]
    |> Shared.mem_to_map()
    assert Intcode.step(list, 0) |> to_list() == [2,0,0,0,99]
  end

  test "step multiply" do
    list = [2,3,0,3,99]
    |> Shared.mem_to_map()
    assert Intcode.step(list, 0) |> to_list() == [2,3,0,6,99]
  end

  test "step value after 99" do
    list = [2,4,4,5,99,0]
    |> Shared.mem_to_map()
    assert Intcode.step(list, 0) |> to_list() == [2,4,4,5,99,9801]
  end

  test "step modify termination" do
    list = [1,1,1,4,99,5,6,0,99]
    |> Shared.mem_to_map()
    assert Intcode.step(list, 0) |> to_list() == [30,1,1,4,2,5,6,0,99]
  end

  def to_list(mem) do
    size = map_size(mem)

    Map.take(mem, 0..size-1 |> Enum.to_list)
    |> Map.values()
  end
end
