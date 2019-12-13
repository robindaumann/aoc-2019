defmodule Day11 do
  alias Intcode.Shared

  @dirs [:up, :right, :down, :left]

  def part1(path) do
    res = Intcode.read_path(path) |> start(%{})

    res.painted |> Enum.count
  end

  def part2(path) do
    res = Intcode.read_path(path) |> start(%{ {0,0} => 1 })

    res.painted |> visualize()
  end

  def start(prog, painted) do
    dev = Shared.create_io(self())
    brain = spawn_link(Intcode, :run, [prog, dev])

    state = init(brain, painted)
    loop(state)
  end

  def init(pid, painted) do
    painted = painted
    pos = {0,0}
    dir = 0

    %{brain: pid, painted: painted, pos: pos, dir: dir}
  end

  def loop(%{brain: brain, painted: painted, pos: pos} = state) do
    send(brain, color(painted, pos))

    receive do
      :halt -> state
      command -> process_paint(command, state) |> loop()
    after
      1000 -> raise RuntimeError
    end
  end

  defp process_paint(command, %{painted: painted, pos: pos} = state) do
    painted = paint(painted, pos, command)

    # if we received one command there should be another on sent
    {dir, pos} =
      receive do
        command -> process_move(command, state)
      after
        1000 -> raise RuntimeError
      end

    %{state | painted: painted, dir: dir, pos: pos }
  end

  defp process_move(command, %{dir: dir, pos: pos}) do
    dir = turn(dir, command)
    pos = get_dir(dir) |> move(pos)
    {dir, pos}
  end

  def get_dir(dir), do: Enum.at(@dirs, dir)

  defp color(painted, pos) do
    Map.get(painted, pos, 0)
  end

  defp paint(painted, pos, color) do
    Map.put(painted, pos, color)
  end

  defp turn(dir, 0), do: rem(dir - 1, 4)
  defp turn(dir, 1), do: rem(dir + 1, 4)

  defp move(:up,    {x,y}), do: {x,y+1}
  defp move(:down,  {x,y}), do: {x,y-1}
  defp move(:left,  {x,y}), do: {x-1,y}
  defp move(:right, {x,y}), do: {x+1,y}

  def visualize(painted) do
    {min_x, max_x} = min_max(painted, 0)
    {min_y, max_y} = min_max(painted, 1)

    grid = max_y..min_y
    |> Enum.reduce("", fn y, acc ->
      acc <> Enum.reduce(min_x..max_x, "", fn x, acc ->
        acc <> if color(painted, {x,y}) == 1, do: "#", else: "." end) <> "\n"
      end)

    Input.show("Day11 registration identifier", grid)
  end

  def min_max(painted, idx) do
    painted
    |> Stream.map(&elem(&1, 0))
    |> Stream.map(&elem(&1, idx))
    |> Enum.min_max()
  end
end
