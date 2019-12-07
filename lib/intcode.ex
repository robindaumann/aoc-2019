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

  def execute(list, index) do
    slice = Enum.slice(list, index)
    decode(slice, list)
  end

  def decode([99 | _], mem) do
    {:halt, mem}
  end

  def decode([instr | list], mem) do
    instr = decode_instr(instr)
    len = Keyword.fetch!(instr, :length)

    parms = Enum.slice(list, 0..len-1)

    res = [ {:parms, parms} | instr ]
    {:cont, res }
  end

  defp _execute(list, f, s1, s2, d) do
    res = f.(Enum.at(list, s1), Enum.at(list, s2))
    list = List.replace_at(list, d, res)
    {:cont, list}
  end

  def decode_instr(instr) do
    res = case rem(instr, 100) do
      1 -> [operation: &+/2, length: 4]
      2 -> [operation: &*/2, length: 4]
      3 -> [operation: &IO.read/2, length: 2]
      4 -> [operation: &IO.write/2, length: 2]
    end

    modes = decode_modes(instr, Keyword.fetch!(res, :length))

    [ {:modes, modes} | res ]
  end

  def decode_modes(instr, length) do
    for i <- 2..length, do: rem(div(instr, pow(10, i)),10)
  end

  defp pow(base, exp) do
    :math.pow(base, exp) |> round
  end


end
