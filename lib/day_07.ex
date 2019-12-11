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
    phases
    |> Enum.reverse
    |> Enum.reduce(self(), fn phase, pid -> run(prog, phase, pid) end)
    |> send(0)

    receive do
      val -> {phases, val}
    end
  end

  def run(prog, phase, target_pid) do
    dev = create_dev(target_pid)
    pid = spawn Intcode, :run, [prog, dev]

    send pid, phase

    pid
  end

  def create_dev(target_pid) do
    read = fn -> receive do x -> x end end
    write = fn val -> send(target_pid, val) end

    %{read: read, write: write, pid: target_pid}
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
