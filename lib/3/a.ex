to_left = 3

{index_list, _} =
  File.stream!("./lib/3/input.txt")
  |> Enum.map(&String.replace(&1, "\n", ""))
  |> Enum.map_reduce(0, fn row, x ->
    char = String.at(row, x)

    x =
      cond do
        x + to_left > String.length(row) - 1 ->
          x - String.length(row) + to_left

        true ->
          x + to_left
      end

    {char, x}
  end)

Enum.filter(index_list, &(&1 == "#"))
|> Enum.count()
|> IO.inspect(limit: :infinity)
