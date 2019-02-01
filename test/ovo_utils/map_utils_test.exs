defmodule OvoUtils.MapUtilsTest do
  use ExUnit.Case

  alias OvoUtils.MapUtils

  describe "transorm_keys" do
    doctest(MapUtils)

    test "returns unchanged input when transforming with identity function" do
      input_map = %{"a" => %{"a" => "hello", "b" => %{"a" => "world"}}}

      assert input_map |> MapUtils.transform_keys(& &1) == input_map, "Input is unchanged"
    end

    test "correctly traverses complex input with nested maps and lists" do
      assert %{
               "a" => %{"a" => "hello", "b" => %{"a" => "world"}},
               "b" => [%{"a" => "foo"}, %{"a" => "bar"}]
             }
             |> MapUtils.transform_keys(&String.to_atom/1) ==
               %{
                 a: %{a: "hello", b: %{a: "world"}},
                 b: [%{a: "foo"}, %{a: "bar"}]
               },
             "all keys including those in nested maps and lists are transformed"
    end
  end
end
