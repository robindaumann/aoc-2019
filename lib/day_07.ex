defmodule Day07 do
  def part1(path) do
    read(path)
    |> max_phases
  end

  def max_phases(prog) do
    0..4
    |> Enum.to_list
    |> permutations
    |> Enum.map(&run_pipe(prog, &1))
    |> Enum.max_by(&elem(&1,1))
  end

  def run_pipe(prog, phases) do
    signal = Enum.reduce(phases, 0, fn phase, signal -> run(prog, phase, signal) end)
    {phases, signal}
  end

  def run(prog, phase, signal) do
    {:ok, dev} = [phase, signal]
    |> Enum.join("\n")
    |> StringIO.open

    Intcode.run(prog, dev)

    {:ok, {"", out}} = StringIO.close(dev)
    out |> String.trim |> String.to_integer
  end

  def read(path) do
    path
    |> File.read!
    |> Intcode.read
  end

  def permutations([]), do: [[]]

  def permutations(list) do
    for elem <- list, rest <- permutations(list--[elem]), do: [elem|rest]
  end
end
