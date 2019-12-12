defmodule Day05 do
  alias Intcode.Shared

  def part1(path) do
    device = Shared.create_dev("1")
    path
    |> Intcode.read_path()
    |> Intcode.run(device)

    device.pid
  end

  def part2(path) do
    device = Shared.create_dev("5")
    path
    |> Intcode.read_path()
    |> Intcode.run(device)

    device.pid
  end
end
