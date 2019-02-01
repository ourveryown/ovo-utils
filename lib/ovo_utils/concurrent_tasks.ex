defmodule OvoUtils.ConcurrentTasks do
  @moduledoc """
  Utility functions for common tasks involving concurrent tasks.
  """

  @doc """
  Concurrently executes functions and returns the results in a map.

  Expects a list of tuples containing a key and a zero arity function that returns either {:ok, result} or {:error, reason}.

  These functions are then executed concurrently and their results are returned together in a map indexed by their keys.

  Returns
    * {:ok, map} if all functions return an :ok tuple
    * {:error, reason}, if any function:
      * returns an :error tuple
      * does not complete before timeout
      * exits without returning a value

  ## Examples

      iex> ConcurrentTasks
      ...>  .populate_map_with_concurrent_functions([
      ...>    {:key1, fn -> {:ok, 2 + 2} end},
      ...>    {:key2, fn -> {:ok, 2 * 3} end}
      ...>  ])
      {:ok, %{key1: 4, key2: 6}}
  """
  def populate_map_with_concurrent_functions(functions, timeout \\ 5000) do
    tasks_with_keys =
      functions
      |> Enum.map(fn {key, function} ->
        {key, Task.async(function)}
      end)

    tasks_with_keys
    |> Enum.map(fn {_key, task} -> task end)
    |> Task.yield_many(timeout)
    |> Enum.reduce_while({:ok, %{}}, fn {task, yield_result}, {:ok, acc} ->
      {task_key, _task} =
        tasks_with_keys |> Enum.find(fn {_key, keyed_task} -> keyed_task == task end)

      case yield_result do
        nil ->
          {:halt, {:error, "Task for key #{task_key} timed out"}}

        {:exit, reason} ->
          {:halt, {:error, "Task for key #{task_key} exited with reason: #{reason}"}}

        {:ok, {:error, error}} when is_binary(error) ->
          {:halt, {:error, "Task for key #{task_key} returned the error: #{error}"}}

        {:ok, {:error, _error}} ->
          {:halt, {:error, "Task for key #{task_key} returned an error"}}

        {:ok, {:ok, result}} ->
          {:cont, {:ok, Map.put(acc, task_key, result)}}
      end
    end)
  end
end
