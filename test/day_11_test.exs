defmodule Day11Test do
  use ExUnit.Case, async: true
  require Input

  test "part1 input" do
    path = Input.path()
    assert Day11.part1(path) == 2219
  end

  test "part2 input" do
    path = Input.path()
    assert Day11.part2(path) == """
    .#..#..##..####.#..#.#.....##..###..####...
    .#..#.#..#.#....#..#.#....#..#.#..#.#......
    .####.#..#.###..#..#.#....#..#.#..#.###....
    .#..#.####.#....#..#.#....####.###..#......
    .#..#.#..#.#....#..#.#....#..#.#....#......
    .#..#.#..#.#.....##..####.#..#.#....####...
    """
  end

  test "part1 example" do
    state = Day11.init(self(), %{})

    task = Task.async(Day11, :loop, [state])
    robot = task.pid

    assert_msg(0)
    send_msg(robot, {1,0})

    assert_msg(0)
    send_msg(robot, {0,0})

    assert_msg(0)
    send_msg(robot, {1,0})

    assert_msg(0)
    send_msg(robot, {1,0})

    assert_msg(1)
    send_msg(robot, {0,1})

    assert_msg(0)
    send_msg(robot, {1,0})

    assert_msg(0)
    send_msg(robot, {1,0})

    send(robot, :halt)
    state = Task.await(task)

    assert Day11.get_dir(state.dir) == :left
    assert state.pos == {0,1}
    assert state.painted |> Enum.count == 6
    assert state.painted == %{ {-1, -1} => 1, {-1, 0} => 0, {0, -1} => 1,
      {0, 0} => 0, {1, 0} => 1, {1, 1} => 1 }
  end

  def assert_msg(msg) do
    receive do
      x -> assert x == msg
    after
      100 -> raise RuntimeError
    end
  end

  def send_msg(robot, {x,y}) do
    send(robot,x)
    send(robot,y)
  end
end
