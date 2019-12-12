defmodule Day09 do
  alias Intcode.Shared

  def part1(path) do
    Intcode.read_path(path) |> run("1")
  end

  def part2(path) do
    Intcode.read_path(path) |> run("2")
  end

  def run(prog, input \\ "") do
    dev = Shared.create_dev(input)
    Intcode.run(prog, dev)
    Shared.get_output(dev.pid)
  end
end
