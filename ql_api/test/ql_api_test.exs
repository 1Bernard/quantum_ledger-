defmodule QlApiTest do
  use ExUnit.Case
  doctest QlApi

  test "greets the world" do
    assert QlApi.hello() == :world
  end
end
