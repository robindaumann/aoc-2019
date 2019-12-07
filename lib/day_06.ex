defmodule Day06 do
  def part1(stream) do
    g = stream
    |> IO.stream(:line)
    |> graph(&insert_directed/2)

    g
    |> :digraph.vertices()
    |> Enum.map(&List.wrap/1)
    |> Enum.map(&:digraph_utils.reaching_neighbours(&1, g))
    |> Enum.reduce(0, fn l, acc -> Enum.count(l) + acc end)
  end

  def part2(stream) do
    g = stream
    |> IO.stream(:line)
    |> graph(&insert_undirected/2)

    src = predecessor(g, "YOU")
    dst = predecessor(g, "SAN")

    verts = :digraph.get_short_path(g, src, dst) |> Enum.count
    # num verts - 1 = num edges
    verts - 1
  end

  def predecessor(g, v) do
    [v] = :digraph.in_neighbours(g, v)
    v
  end

  def graph(lst, insert_f) do
    g = :digraph.new()

    lst
    |> Enum.map(&parse/1)
    |> Enum.reduce(g, insert_f)
  end

  def parse(row) do
    row
    |> String.split(")")
    |> Enum.map(&String.trim/1)
  end

  def insert_directed([v1, v2], g) do
    :digraph.add_vertex(g, v1)
    :digraph.add_vertex(g, v2)
    :digraph.add_edge(g, v1, v2)
    g
  end

  def insert_undirected(list = [v1, v2], g) do
    g = insert_directed(list, g)
    :digraph.add_edge(g, v2, v1)
    g
  end
end
