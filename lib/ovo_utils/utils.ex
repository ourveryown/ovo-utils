defmodule OvoUtils.Utils do
  @moduledoc """
  Miscellaneous utility functions.
  """

  @doc """
  Applies a function to a value inside an {:ok | :error, value} tuple if atom is :ok, otherwise returns the tuple without applying the function.

  ## Examples

      iex> {:ok, 2} |> Utils.apply_on_ok(fn x -> x + 2 end)
      {:ok, 4}

      iex> {:error, "reason"} |> Utils.apply_on_ok(fn x -> x + 2 end)
      {:error, "reason"}

      iex> {:ok, 2} |> Utils.apply_on_ok(fn x -> {:ok, x + 2} end)
      {:ok, 4}

      iex> {:ok, 2} |> Utils.apply_on_ok(fn _ -> {:error, "reason"} end)
      {:error, "reason"}
  """
  def apply_on_ok({:ok, data}, function) do
    case function.(data) do
      {atom, result} when is_atom(atom) -> {atom, result}
      result -> {:ok, result}
    end
  end

  def apply_on_ok(other, _function) do
    other
  end
end
