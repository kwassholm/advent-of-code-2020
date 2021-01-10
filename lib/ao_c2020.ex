defmodule AOC2020 do
  use Agent, File

  @moduledoc """
  Documentation for `AOC2020`.
  """

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

  def start(_type, _args) do
    File.stream!("lib/input.txt")
    |> Stream.map(&String.to_integer(String.replace(&1, "\n", "")))
    |> Enum.map(& &1)
  end

  # def start_link(_opts) do
  #   {contents} =
  #     File.stream!("lib/input.txt")
  #     |> Stream.map(&String.to_integer(String.replace(&1, "\n", "")))
  #     |> Enum.map(& &1)

  #   IO.puts(contents)
  #   # Agent.start_link(fn -> %{} end)
  # end

  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end
end
