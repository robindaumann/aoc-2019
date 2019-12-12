defmodule Intcode.Decoder do
  def decode([99 | _]) do
    %{operation: :halt}
  end

  def decode([op_code | list]) do
    op = decode_op(op_code)
    len = op.length

    params = Enum.slice(list, 0..len-1)
    modes = decode_modes(op_code, len)

    {out_len, op} = Map.pop(op, :out_len, 0)
    in_len = len - 1 - out_len
    types = List.duplicate(:in, in_len) ++ List.duplicate(:out, out_len)

    Map.put(op, :params, Enum.zip([params, modes, types]))
  end

  defp decode_op(op_code) do
    case rem(op_code, 100) do
      1 -> %{operation: :add, length: 4, out_len: 1}
      2 -> %{operation: :mult, length: 4, out_len: 1}
      3 -> %{operation: :read, length: 2, out_len: 1}
      4 -> %{operation: :write, length: 2}
      5 -> %{operation: :jump_true, length: 3}
      6 -> %{operation: :jump_false, length: 3}
      7 -> %{operation: :lt, length: 4, out_len: 1}
      8 -> %{operation: :equals, length: 4, out_len: 1}
      9 -> %{operation: :set_rel, length: 2}
    end
  end

  defp decode_modes(op_code, length) do
    for i <- 2..length, do: rem(div(op_code, pow(10, i)),10)
  end

  defp pow(base, exp) do
    :math.pow(base, exp) |> round
  end
end
