defmodule Day3Part2 do
  def toboggan(go_right, go_down) do
    {chars, _} =
      File.stream!("./lib/3/input.txt")
      |> Enum.map(&String.replace(&1, "\n", ""))
      |> Enum.take_every(go_down)
      |> Enum.map_reduce(0, fn row, x ->
        char = String.at(row, x)

        x =
          cond do
            x + go_right > String.length(row) - 1 ->
              x - String.length(row) + go_right

            true ->
              x + go_right
          end

        {char, x}
      end)

    Enum.filter(chars, &(&1 == "#"))
    |> Enum.count()
  end
end

instructions = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

{result, _} =
  Enum.map_reduce(instructions, 0, fn [go_right, go_down], acc ->
    result = Day3Part2.toboggan(go_right, go_down)
    {result, acc + result}
  end)

Enum.reduce(result, &(&1 * &2))
|> IO.inspect()
