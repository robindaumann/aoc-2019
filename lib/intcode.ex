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
    slice = Enum.slice(list, index..index+3)
    case decode(slice, list) do
      {:cont, list} -> step(list, index+4)
      {:halt, list} -> list
    end
  end

  def decode([1, s1, s2, d], list) do
    execute(list, &+/2, s1, s2, d)
  end

  def decode([2, s1, s2, d], list) do
    execute(list, &*/2, s1, s2, d)
  end

  def decode([99 | _], list) do
    {:halt, list}
  end

  defp execute(list, f, s1, s2, d) do
    res = f.(Enum.at(list, s1), Enum.at(list, s2))
    list = List.replace_at(list, d, res)
    {:cont, list}
  end
end
