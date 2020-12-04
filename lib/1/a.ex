defmodule Combinations do
  @doc """
  This function lists all combinations of `num` elements from the given `list`
  Taken from: https://www.adiiyengar.com/blog/20190608/elixir-combinations
  """
  def combinations(list, num)
  def combinations(_list, 0), do: [[]]
  def combinations(list = [], _num), do: list

  def combinations([head | tail], num) do
    Enum.map(combinations(tail, num - 1), &[head | &1]) ++
      combinations(tail, num)
  end
end

contents =
  File.stream!("./lib/1/input.txt")
  |> Stream.map(&String.to_integer(String.replace(&1, "\n", "")))
  |> Enum.map(& &1)
  |> Combinations.combinations(2)
  |> Enum.find(&(Enum.sum(&1) == 2020))
  |> (fn [a, b] -> a * b end).()

IO.inspect(contents)
