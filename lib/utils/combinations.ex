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
