defmodule Day06Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    dev = File.open!(Input.path(), [:read])
    assert Day06.part1(dev) == 344238
  end

  test "part2 input" do
    dev = File.open!(Input.path(), [:read])
    assert Day06.part2(dev) == 436
  end

  test "example part 1" do
    {:ok, dev} = StringIO.open("""
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    """)

    assert Day06.part1(dev) == 42
  end

  test "example part 2" do
    {:ok, dev} = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    K)YOU
    I)SAN
    """ |> StringIO.open()

    assert Day06.part2(dev) == 4
  end

  test "parse row" do
    s = "A)B"
    assert Day06.parse(s) == ["A", "B"]
  end

  test "parse newline" do
    s = "A)B\n"
    assert Day06.parse(s) == ["A", "B"]
  end

  test "parse multi char" do
    s = "A17B)B9+"
    assert Day06.parse(s) == ["A17B", "B9+"]
  end

  test "insert vert and edge" do
    g = :digraph.new
    Day06.insert_directed(["a", "b"], g)

    assert :digraph.vertex(g, "a") == {"a", []}
    assert :digraph.vertex(g, "b") == {"b", []}
    assert :digraph.out_neighbours(g, "a") == ["b"]
    assert :digraph.out_neighbours(g, "b") == []
  end

  test "insert duplicate vert" do
    g = :digraph.new
    Day06.insert_directed(["a", "b"], g)
    Day06.insert_directed(["a", "c"], g)

    assert :digraph.vertex(g, "a") == {"a", []}
    assert :digraph.vertex(g, "b") == {"b", []}
    assert :digraph.vertex(g, "c") == {"c", []}
    assert :digraph.out_neighbours(g, "a") |> Enum.sort == ["b", "c"]
    assert :digraph.out_neighbours(g, "b") == []
    assert :digraph.out_neighbours(g, "c") == []
  end

  test "insert undirected" do
    g = :digraph.new
    Day06.insert_undirected(["a", "b"], g)

    assert :digraph.vertex(g, "a") == {"a", []}
    assert :digraph.vertex(g, "b") == {"b", []}
    assert :digraph.out_neighbours(g, "a") == ["b"]
    assert :digraph.out_neighbours(g, "b") == ["a"]
  end
end
