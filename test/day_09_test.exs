defmodule Day09Test do
  use ExUnit.Case, async: true
  require Input

  test "part1" do
    path = Input.path()
    assert Day09.part1(path) == [2745604242]
  end

  test "example1" do
    prog = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]

    assert Day09.run(prog) == prog
  end

  test "example2" do
    prog = [1102,34915192,34915192,7,4,7,99,0]
    res = Day09.run(prog) |> List.first |> Integer.to_string |> String.length
    assert res == 16
  end

  test "example3" do
    prog = [104,1125899906842624,99]

    assert Day09.run(prog) == Enum.slice(prog,1,1)
  end
end
