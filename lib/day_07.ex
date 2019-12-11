defmodule Day07 do
  def part1(path) do
    read(path)
    |> max_phases(0..4)
  end

  def part2(path) do
    read(path)
    |> max_phases(5..9)
  end

  def max_phases(prog, range) do
    range
    |> Enum.to_list
    |> permutations
    |> Enum.map(&run_pipe(prog, &1))
    |> Enum.max_by(&elem(&1,1))
  end

  def run_pipe(prog, phases) do
    val = phases
    |> Enum.reverse
    |> Enum.reduce(self(), fn phase, pid -> run(prog, phase, pid) end)
    |> await_loop(0)

    {phases, val}
  end

  def await_loop(pid, val) do
    send(pid, val)
    receive do
      :halt -> val
      val -> await_loop(pid, val)
    end
  end

  def run(prog, phase, target_pid) do
    dev = create_io(target_pid)
    pid = spawn Intcode, :run, [prog, dev]

    send pid, phase

    pid
  end

  def create_io(target_pid) do
    read = fn -> receive do x -> x end end
    write = fn val -> send(target_pid, val) end

    %{read: read, write: write, term: write}
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
