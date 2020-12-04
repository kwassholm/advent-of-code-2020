regex = ~r/(?<min>[\d]{1,2})-(?<max>[\d]{1,2})\s(?<target>[\w]):\s(?<passwd>\w+)/

contents =
  File.stream!("./lib/2/input.txt")
  |> Enum.map(&String.replace(&1, "\n", ""))
  |> Enum.map(fn x ->
    %{"min" => min, "max" => max, "target" => target, "passwd" => passwd} =
      Regex.named_captures(regex, x)

    count = Enum.count(String.graphemes(passwd), &(&1 == target))

    if count >= String.to_integer(min) and count <= String.to_integer(max) do
      passwd
    end

    # Enum.count(String.graphemes(passwd), &(&1 == target))
    # |> (fn count ->
    #       cond do
    #         count >= String.to_integer(min) and count <= String.to_integer(max) ->
    #           passwd
    #         true ->
    #           nil
    #       end
    #     end).()
  end)
  |> Enum.filter(&(!is_nil(&1)))
  |> Enum.count()

IO.inspect(contents, limit: :infinity)
