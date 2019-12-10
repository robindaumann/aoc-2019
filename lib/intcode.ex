defmodule Intcode do
  @spec read(binary) :: [integer]
  def read(s) do
    s
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  @spec run([integer], IO.device) :: integer
  def run(mem, dev \\ :none) do
    step(mem, 0, dev) |> hd
  end

  @spec step([integer], integer, IO.device) :: any
  def step(mem, index, dev \\ :none) do
    instr =
    Enum.slice(mem, index..index+3)
    |> decode
    |> Map.put(:index, index)

    case exe(instr, mem, dev) do
      {:cont, mem, index} -> step(mem, index, dev)
      {:halt, mem, _} -> mem
    end
  end

  # execute function is tested via step
  defp exe(%{operation: :add} = instr, mem, _) do
    modes = set_last_one(instr.modes)
    [s1, s2, d] = Enum.zip(instr.params, modes) |> load_params(mem)

    mem = List.replace_at(mem, d, s1+s2)
    {:cont, mem, index(instr)}
  end

  defp exe(%{operation: :mult} = instr, mem, _) do
    modes = set_last_one(instr.modes)
    [s1, s2, d] = Enum.zip(instr.params, modes) |> load_params(mem)

    mem = List.replace_at(mem, d, s1*s2)
    {:cont, mem, index(instr)}
  end

  defp exe(%{operation: :read} = instr, mem, dev) do
    modes = set_last_one(instr.modes)
    [d] = Enum.zip(instr.params, modes) |> load_params(mem)
    {val, _} = IO.read(dev, :line) |> Integer.parse()

    mem = List.replace_at(mem, d, val)
    {:cont, mem, index(instr)}
  end

  defp exe(%{operation: :write} = instr, mem, dev) do
    [val] = Enum.zip(instr.params, instr.modes) |> load_params(mem)

    IO.puts(dev, val)
    {:cont, mem, index(instr)}
  end

  defp exe(%{operation: :halt, index: index}, mem, _) do
    {:halt, mem, index}
  end

  defp set_last_one(modes) do
    # we set the destination parameter to one because it should not be loaded from memory
    List.replace_at(modes, -1, 1)
  end

  defp index(%{index: index, length: length}) do
    index + length
  end

  def load_params(params, mem) do
    Enum.map(params, &load_param(&1, mem))
  end

  defp load_param({index, 0}, mem), do: Enum.at(mem, index)
  defp load_param({literal, 1}, _), do: literal

  def decode([99 | _]) do
    %{operation: :halt}
  end

  def decode([op_code | list]) do
    op = decode_op(op_code)
    len = op.length

    params = Enum.slice(list, 0..len-1)
    modes = decode_modes(op_code, len)

    op
    |> Map.put(:params, params)
    |> Map.put(:modes, modes)
  end

  defp decode_op(op_code) do
    case rem(op_code, 100) do
      1 -> %{operation: :add, length: 4}
      2 -> %{operation: :mult, length: 4}
      3 -> %{operation: :read, length: 2}
      4 -> %{operation: :write, length: 2}
      5 -> %{operation: :jump_true, length: 3}
      6 -> %{operation: :jump_false, length: 3}
      7 -> %{operation: :lt, length: 4}
      8 -> %{operation: :equals, length: 4}
    end
  end

  defp decode_modes(op_code, length) do
    for i <- 2..length, do: rem(div(op_code, pow(10, i)),10)
  end

  defp pow(base, exp) do
    :math.pow(base, exp) |> round
  end
end
