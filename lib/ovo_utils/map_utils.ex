defmodule OvoUtils.MapUtils do
  @moduledoc """
  Utility functions for common operations on maps.
  """

  @doc """
  Applies a transformation function on map keys.

  Recursively traverses nested maps and lists.

  ## Examples

      iex> %{"a" => "foo", "b" => "bar"} |> MapUtils.transform_keys(fn key -> key <> "_new" end)
      %{"a_new" => "foo", "b_new" => "bar"}
  """
  def transform_keys(map, transformation) when is_map(map) do
    map
    |> Map.new(fn {key, value} ->
      {transformation.(key), transform_keys(value, transformation)}
    end)
  end

  def transform_keys(list, transformation) when is_list(list) do
    list
    |> Enum.map(fn element -> transform_keys(element, transformation) end)
  end

  def transform_keys(value, _transformation) do
    value
  end

  @doc """
  Converts string keys in maps to atoms.

  Recursively traverses nested maps and lists.

  ## Note
  Expects every key of all nested maps to be strings.

  ## Examples

      iex> %{"a" => "foo", "b" => "bar"} |> MapUtils.atomise_string_keys()
      %{a: "foo", b: "bar"}
  """
  def atomise_string_keys(element) do
    transform_keys(element, &String.to_existing_atom/1)
  end

  @doc """
  Converts all string keys in a map to atom keys.

  Recursively traverses nested maps and lists.

  ## Examples

      iex> %{a: "foo", b: "bar"} |> MapUtils.stringify_atom_keys()
      %{"a" => "foo", "b" => "bar"}
  """
  def stringify_atom_keys(element) do
    transform_keys(element, &Atom.to_string/1)
  end

  @doc """
  Converts all string keys in a map to camel case.

  Recursively traverses nested maps and lists.

  ## Examples

      iex> %{"foo_bar" => "a", "bar_foo" => "b"} |> MapUtils.camelize_string_keys()
      %{"fooBar" => "a", "barFoo" => "b"}
  """
  def camelize_string_keys(element) do
    transform_keys(element, &Recase.to_camel/1)
  end

  @doc """
  Converts all string keys in a map to to snake case.

  Recursively traverses nested maps and lists.

  ## Examples

      iex> %{"fooBar" => "a", "barFoo" => "b"} |> MapUtils.snakify_string_keys()
      %{"foo_bar" => "a", "bar_foo" => "b"}
  """
  def snakify_string_keys(element) do
    transform_keys(element, &Recase.to_snake/1)
  end
end
