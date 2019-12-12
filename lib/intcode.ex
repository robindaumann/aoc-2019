defmodule Intcode do
  alias Intcode.{Decoder, Engine, Shared}

  @spec read_path(Path.t) :: [integer]
  def read_path(path) do
    File.read!(path) |> read
  end

  @spec read(binary) :: [integer]
  def read(s) do
    s
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def run(mem, dev \\ %{}) do
    mem = Shared.mem_to_map(mem)
    step(mem, 0, dev) |> Map.fetch!(0)
  end

  def step(mem, index, dev \\ %{}) do
    instr = next_instr(mem, index)

    case Engine.exe(instr, mem, dev) do
      {:cont, mem, index} -> step(mem, index, dev)
      {:halt, mem, _} -> mem
    end
  end

  defp next_instr(mem, index) do
    mem
    |> Map.take(index..index+3 |> Enum.to_list())
    |> Map.values
    |> Decoder.decode
    |> Map.put(:index, index)
  end
end
