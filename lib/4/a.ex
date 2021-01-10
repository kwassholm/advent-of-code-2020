defmodule Passport do
  @enforce_keys [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]
  defstruct [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid]
end

defmodule Day4 do
  def test_extra_validness(v) do
    Enum.map(v, fn x ->
      is_strictly_valid_passport(x)
      # |> IO.inspect()
    end)
  end

  def is_strictly_valid_passport(v)
      when v.byr >= 1920 and v.byr <= 2002 and
             v.iyr >= 2010 and v.iyr <= 2020 and
             v.eyr >= 2020 and v.eyr <= 2030 and
             ((elem(v.hgt, 1) == "cm" and elem(v.hgt, 0) >= 150 and
                 elem(v.hgt, 0) <= 193) or
                (elem(v.hgt, 1) == "in" and elem(v.hgt, 0) >= 59 and
                   elem(v.hgt, 0) <= 76)) and
             v.ecl in ["amb", "blum", "brn", "gry", "grn", "hzl", "oth"] do
    if String.length(v.pid) == 9 and String.match?(v.hcl, ~r/^(?:#[0-9a-f]{6})$/) do
      # IO.inspect(v)
      :valid
    else
      :not_valid
    end
  end

  def is_strictly_valid_passport(v) do
    IO.inspect(v)
    :not_valid
  end

  def create_passport(v) do
    try do
      struct!(Passport, v)
    rescue
      ArgumentError ->
        nil
    end
  end

  def map_to_passport_struct(x) do
    x
    |> Map.new(fn {k, v} ->
      v =
        case k do
          "hgt" ->
            if String.ends_with?(v, ["cm", "in"]) do
              {a, b} = String.split_at(v, -2)
              {String.to_integer(a), b}
            end

          x when x in ["byr", "iyr", "eyr"] ->
            String.to_integer(v)

          _ ->
            v
        end

      {String.to_existing_atom(k), v}
    end)
    |> create_passport()

    # |> IO.inspect()
  end

  def create_valid_passports do
    chunk_fun = fn row, acc ->
      cond do
        row == "" -> {:cont, acc, []}
        true -> {:cont, [row | acc]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, acc, []}
    end

    {result, _} =
      File.stream!("./lib/4/input.txt")
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Stream.chunk_while([], chunk_fun, after_fun)
      |> Enum.map_reduce([], fn x, acc ->
        result =
          Enum.map_join(x, " ", & &1)
          |> String.split(" ")
          |> Enum.map(&String.split(&1, ":"))
          |> Map.new(&List.to_tuple/1)
          |> map_to_passport_struct()

        {result, acc}
      end)

    Enum.filter(result, &(&1 != nil))
  end
end

# Day4.create_valid_passports()
# |> Enum.count()
# |> IO.puts()

Day4.create_valid_passports()
|> Day4.test_extra_validness()
|> Enum.filter(&(&1 == :valid))
|> Enum.count()
|> IO.inspect(limit: :infinity)
