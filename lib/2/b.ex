regex = ~r/(?<pos1>[\d]{1,2})-(?<pos2>[\d]{1,2})\s(?<target>[\w]):\s(?<passwd>\w+)/

contents =
  File.stream!("./lib/2/input.txt")
  |> Enum.map(&String.replace(&1, "\n", ""))
  |> Enum.map(fn x ->
    %{"pos1" => pos1, "pos2" => pos2, "target" => target, "passwd" => passwd} =
      Regex.named_captures(regex, x)

    String.graphemes(passwd)
    |> (fn list ->
          case [
            Enum.at(list, String.to_integer(pos1) - 1) == target,
            Enum.at(list, String.to_integer(pos2) - 1) == target
          ] do
            [true, false] -> :jep
            [false, true] -> :jep
            _ -> :nope
          end
        end).()
  end)
  |> Enum.filter(&(&1 == :jep))
  |> Enum.count()

IO.inspect(contents, limit: :infinity)
