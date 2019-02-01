defmodule OvoUtils.ConcurrentTasksTest do
  use ExUnit.Case

  alias OvoUtils.ConcurrentTasks

  doctest(ConcurrentTasks)

  test "tasks succeed" do
    assert ConcurrentTasks.populate_map_with_concurrent_functions([
             {:key1, fn -> {:ok, 2 + 2} end},
             {:key2, fn -> {:ok, 2 * 3} end}
           ]) == {:ok, %{key1: 4, key2: 6}}
  end

  test "single task fails" do
    assert ConcurrentTasks.populate_map_with_concurrent_functions([
             {:key1, fn -> {:ok, 2 + 2} end},
             {:key2, fn -> {:error, "Error Message"} end}
           ]) == {:error, "Task for key key2 returned the error: Error Message"}
  end

  test "if multiple errors occur, first error returned in tuple" do
    assert ConcurrentTasks.populate_map_with_concurrent_functions([
             {:key1, fn -> {:error, "Error Message 1"} end},
             {:key2, fn -> {:error, "Error Message 2"} end}
           ]) == {:error, "Task for key key1 returned the error: Error Message 1"}
  end

  test "if error is not a string return a generic message" do
    assert ConcurrentTasks.populate_map_with_concurrent_functions([
             {:key1, fn -> {:error, %{reason: "error"}} end},
             {:key2, fn -> {:error, "Error Message 2"} end}
           ]) == {:error, "Task for key key1 returned an error"}
  end

  test "returns a timeout error if the task took too long" do
    assert ConcurrentTasks.populate_map_with_concurrent_functions(
             [
               {:key1, fn -> {:ok, 2 + 2} end},
               {:key2,
                fn ->
                  Process.sleep(100)
                  {:ok, 2 + 6}
                end}
             ],
             1
           ) == {:error, "Task for key key2 timed out"}
  end

  test "returns error if a task ecits without returning a value" do
    assert ConcurrentTasks.populate_map_with_concurrent_functions([
             {:key1, fn -> Process.exit(self(), :normal) end}
           ]) == {:error, "Task for key key1 exited with reason: normal"}
  end
end
