defmodule Intcode.Shared do
  def mem_to_map(mem) do
    0..length(mem)-1 |> Stream.zip(mem) |> Enum.into(%{base: 0})
  end

  def create_dev(content) do
    {:ok, pid} = StringIO.open(content)
    read = fn -> IO.read(pid, :line) |> Integer.parse |> elem(0) end
    write = fn val -> IO.puts(pid, val) end

    %{read: read, write: write, pid: pid}
  end

  def get_output(device) do
    StringIO.flush(device)
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def create_io(target_pid) do
    read = fn -> receive do x -> x end end
    write = fn val -> send(target_pid, val) end

    %{read: read, write: write, term: write}
  end
end
