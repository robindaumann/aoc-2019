defmodule Intcode do
  @spec read(binary) :: [integer]
  def read(s) do
    s
    |> String.trim
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  @spec run([integer]) :: integer
  def run(list) do
    step(list, 0) |> hd
  end

  def step(list, index) do
    case execute(list, index) do
      {:cont, list, len} -> step(list, index+len)
      {:halt, list} -> list
    end
  end

  def execute(mem, []) do
    slice = Enum.slice(list, index)
    decode(slice)
  end

  defp _execute(list, f, s1, s2, d) do
    res = f.(Enum.at(list, s1), Enum.at(list, s2))
    list = List.replace_at(list, d, res)
    {:cont, list}
  end

  def decode([99 | _]) do
    [operation: :halt]
  end

  def decode([op_code | list]) do
    op = decode_op(op_code)
    len = op[:length]

    parms = Enum.slice(list, 0..len-1)
    modes = decode_modes(op_code, len)

    [{:parms, parms} | [{:modes, modes} | op]]
  end

  defp decode_op(op_code) do
    case rem(op_code, 100) do
      1 -> %{operation: :add, length: 4}
      2 -> %{operation: :mult, length: 4}
      3 -> %{operation: :read, length: 2}
      4 -> %{operation: :write, length: 2}
    end
  end

  defp decode_modes(op_code, length) do
    for i <- 2..length, do: rem(div(op_code, pow(10, i)),10)
  end

  defp pow(base, exp) do
    :math.pow(base, exp) |> round
  end
end
