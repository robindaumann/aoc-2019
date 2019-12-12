defmodule Intcode.Engine do
  def exe(%{operation: :add} = instr, mem, _) do
    modes = set_last_one(instr.modes)
    [s1, s2, d] = Enum.zip(instr.params, modes) |> load_params(mem)

    mem = write_mem(mem, d, s1+s2)
    {:cont, mem, inc_index(instr)}
  end

  def exe(%{operation: :mult} = instr, mem, _) do
    modes = set_last_one(instr.modes)
    [s1, s2, d] = Enum.zip(instr.params, modes) |> load_params(mem)

    mem = write_mem(mem, d, s1*s2)
    {:cont, mem, inc_index(instr)}
  end

  def exe(%{operation: :read} = instr, mem, dev) do
    modes = set_last_one(instr.modes)
    [d] = Enum.zip(instr.params, modes) |> load_params(mem)
    val = dev.read.()

    mem = write_mem(mem, d, val)
    {:cont, mem, inc_index(instr)}
  end

  def exe(%{operation: :write} = instr, mem, dev) do
    [val] = Enum.zip(instr.params, instr.modes) |> load_params(mem)

    dev.write.(val)
    {:cont, mem, inc_index(instr)}
  end

  def exe(%{operation: :jump_true} = instr, mem, _) do
    [condi, target] = Enum.zip(instr.params, instr.modes) |> load_params(mem)

    index = if condi != 0, do: target, else: inc_index(instr)
    {:cont, mem, index}
  end

  def exe(%{operation: :jump_false} = instr, mem, _) do
    [condi, target] = Enum.zip(instr.params, instr.modes) |> load_params(mem)

    index = if condi == 0, do: target, else: inc_index(instr)
    {:cont, mem, index}
  end

  def exe(%{operation: :lt} = instr, mem, _) do
    modes = set_last_one(instr.modes)
    [s1, s2, d] = Enum.zip(instr.params, modes) |> load_params(mem)

    val = if s1 < s2, do: 1, else: 0

    mem = write_mem(mem, d, val)
    {:cont, mem, inc_index(instr)}
  end

  def exe(%{operation: :equals} = instr, mem, _) do
    modes = set_last_one(instr.modes)
    [s1, s2, d] = Enum.zip(instr.params, modes) |> load_params(mem)

    val = if s1 == s2, do: 1, else: 0

    mem = write_mem(mem, d, val)
    {:cont, mem, inc_index(instr)}
  end

  def exe(%{operation: :set_rel} = instr, mem, _) do
    [val] = Enum.zip(instr.params, instr.modes) |> load_params(mem)

    mem = Map.update!(mem, :base, &(&1 + val))
    {:cont, mem, inc_index(instr)}
  end

  def exe(%{operation: :halt, index: index}, mem, dev) do
    if Map.has_key?(dev, :term) do
      dev.term.(:halt)
    end

    {:halt, mem, index}
  end

  defp write_mem(mem, pos, val) do
    Map.put_new(mem, pos, 0)
    |> Map.replace!(pos, val)
    # diff = pos - length(mem) + 1
    # mem = if diff > 0, do: mem ++ List.duplicate(0, diff), else: mem
    # List.replace_at(mem, pos, val)
  end

  defp set_last_one(modes) do
    # we set the destination parameter to one because it should not be loaded from memory
    if List.last(modes) == 0, do: List.replace_at(modes, -1, 1), else: modes
  end

  defp inc_index(%{index: index, length: length}) do
    index + length
  end

  def load_params(params, mem) do
    Enum.map(params, &load_param(&1, mem))
  end

  defp load_param({index, 0}, mem), do: Map.get(mem, index, 0)
  defp load_param({index, 2}, mem), do: Map.get(mem, mem.base + index, 0)
  defp load_param({literal, 1}, _), do: literal
end
