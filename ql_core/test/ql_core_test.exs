defmodule QlCoreTest do
  use ExUnit.Case
  doctest QlCore

  test "greets the world" do
    assert QlCore.hello() == :world
  end
end
