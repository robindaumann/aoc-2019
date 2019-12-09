defmodule Day08Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    f = Input.path() |> File.open!
    assert Day08.part1(f, 25, 6) == 1072
  end

  test "part1 example" do
    {:ok, dev} = StringIO.open("111222000999")
    assert Day08.part1(dev, 3, 2) == 9
  end

  test "part2 example" do
    {:ok, dev} = StringIO.open("0222112222120000")
    img = Day08.part2(dev, 2, 2)
    assert img == [[0, 1], [1, 0]]
  end

  test "part2 input" do
    f = Input.path() |> File.open!
    img = Day08.part2(f, 25, 6)
    assert img
    unless System.get_env("GITHUB_ACTION") do
      IO.puts("")
      IO.puts(Day08.show(img))
      IO.puts("")
    end
  end

  test "overlap_all 1" do
    l = [0, 1, 2, 0]
    assert Day08.overlap_all(l) == 0
  end

  test "overlap_all 2" do
    l = [2, 1, 2, 0]
    assert Day08.overlap_all(l) == 1
  end

  test "overlap_all 3" do
    l = [2, 2, 1, 0]
    assert Day08.overlap_all(l) == 1
  end

  test "overlap_all 4" do
    l = [2, 2, 2, 0]
    assert Day08.overlap_all(l) == 0
  end


  test "layers" do
    s = "123456789012"
    size = 3 * 2
    assert Day08.layers(s, size) == [[1,2,3,4,5,6], [7,8,9,0,1,2]]
  end

  test "min zeros" do
    layers = [[1,0], [1,1]]
    assert Day08.min_zeros(layers) == 1
  end
end
