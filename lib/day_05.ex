defmodule Day05 do
  def part1(path) do
    {:ok, device} = StringIO.open("1")
    path
    |> read()
    |> Intcode.run(device)

    device
  end

  defp read(path) do
    path
    |> File.read!
    |> Intcode.read
  end
end
