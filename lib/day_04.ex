defmodule Day04 do
  @spec part1(binary) :: non_neg_integer
  def part1(input) do
    solve(input, &pw_criteria?/1)
  end

  @spec part2(binary) :: non_neg_integer
  def part2(input) do
    solve(input, &extended_criteria?/1)
  end

  def solve(input, criteria) do
    [lower, upper] = String.split(input, "-") |> Enum.map(&String.to_integer/1)

    lower..upper
    |> Stream.map(&Integer.to_string/1)
    |> Stream.filter(criteria)
    |> Enum.count
  end

  def extended_criteria?(s) do
    pw_criteria?(s) && double?(s, 0, 0)
  end

  def pw_criteria?(pw), do: repitition?(pw) && increases?(pw)

  def repitition?(s) when byte_size(s) < 2, do: false

  def repitition?(<<x,y, rest :: binary >>) do
    x == y || repitition?(<<y>> <>  rest)
  end

  def increases?(s) when byte_size(s) < 2, do: true

  def increases?(<<x,y, rest :: binary >>) do
      x <= y && increases?(<<y>> <>  rest)
  end

  def double?("", _, num) do
    num == 2
  end

  def double?(<<x, rest:: binary>>, char, num) when x == char do
    double?(rest, char, num+1)
  end

  def double?(<<x, rest:: binary>>, char, num) when x != char do
    num == 2 || double?(rest, x, 1)
  end
end
