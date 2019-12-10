defmodule Day05Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    path = Input.path()
    dev = Day05.part1(path)

    [res] = dev
    |> get_output
    |> Enum.filter(fn x -> x != "0" end)

    assert res == "3122865"
  end

  test "part2 input" do
    path = Input.path()
    dev = Day05.part2(path)

    [res] = get_output(dev)

    assert res == "773660"
  end

  test "input equals 8 position mode" do
    list = [3,9,8,9,10,9,4,9,99,-1,8]
    compare_io("8","1",list)
    compare_io("22","0",list)
  end

  test "input equals 8 immediate mode" do
    list = [3,3,1108,-1,8,3,4,3,99]
    compare_io("8","1",list)
    compare_io("-3","0",list)
  end

  test "input lt 8 position mode" do
    list = [3,9,7,9,10,9,4,9,99,-1,8]
    compare_io("7","1",list)
    compare_io("999","0",list)
  end

  test "input lt 8 immediate mode" do
    list = [3,3,1107,-1,8,3,4,3,99]
    compare_io("7","1",list)
    compare_io("999","0",list)
  end

  test "jump echo position mode" do
    list = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
    compare_io("0","0",list)
    compare_io("1","1",list)
  end

  test "jump echo immediate mode" do
    list = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
    compare_io("0","0",list)
    compare_io("1","1",list)
  end

  test "large example part2" do
    list = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
    1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
    999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]

    compare_io("0","999",list)
    compare_io("8","1000",list)
    compare_io("99","1001",list)
  end

  def compare_io(input, expect, mem) do
    {:ok, dev} = StringIO.open(input)

    Intcode.step(mem, 0, dev)

    [output] = get_output(dev)

    assert output == expect
  end

  def get_output(device) do
    StringIO.flush(device)
    |> String.trim_trailing()
    |> String.split("\n")
  end
end
