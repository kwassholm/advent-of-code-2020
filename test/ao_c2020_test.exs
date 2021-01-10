defmodule AOC2020Test do
  use ExUnit.Case, async: true
  doctest AOC2020

  setup do
    {:ok, bucket} = AOC2020.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert AOC2020.get(bucket, "milk") == nil

    AOC2020.put(bucket, "milk", 3)
    assert AOC2020.get(bucket, "milk") == 3
  end
end
