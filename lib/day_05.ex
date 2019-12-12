defmodule Day05 do
  alias Intcode.Shared

  def part1(path) do
    device = Shared.create_dev("1")
    path
    |> read()
    |> Intcode.run(device)

    device.pid
  end

  def part2(path) do
    device = Shared.create_dev("5")
    path
    |> read()
    |> Intcode.run(device)

    device.pid
  end

  defp read(path) do
    path
    |> File.read!
    |> Intcode.read
  end
end
