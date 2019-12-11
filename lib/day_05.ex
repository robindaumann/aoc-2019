defmodule Day05 do
  def part1(path) do
    device = create_dev("1")
    path
    |> read()
    |> Intcode.run(device)

    device.pid
  end

  def part2(path) do
    device = create_dev("5")
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

  def create_dev(content) do
    {:ok, pid} = StringIO.open(content)
    read = fn -> IO.read(pid, :line) |> Integer.parse |> elem(0) end
    write = fn val -> IO.puts(pid, val) end

    %{read: read, write: write, pid: pid}
  end
end
