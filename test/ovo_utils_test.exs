defmodule OvoUtilsTest do
  use ExUnit.Case
  doctest OvoUtils

  test "greets the world" do
    assert OvoUtils.hello() == :world
  end
end
