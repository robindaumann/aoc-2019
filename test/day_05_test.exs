defmodule Day05Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    path = Input.path()
    dev = Day05.part1(path)

    [res] = StringIO.flush(dev)
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.filter(fn x -> x != "0" end)

    assert res == "3122865"
  end
end
