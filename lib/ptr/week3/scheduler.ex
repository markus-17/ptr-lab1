defmodule Ptr.Week3.Scheduler do
  @doc """
  Create a module that would perform some risky business. When receiving a task to do, it will create a worker node
  that will perform the task. Given the nature of the task, the worker has 50% probability of failure. If the scheduler detects
  a crash, it will log it, and restart the worker node. If the worker node finishes successfully, it should print the result.
  """
  def schedule(args) do
    pid =
      spawn(fn ->
        case :rand.uniform(2) do
          1 ->
            Process.exit(self(), :failure)

          2 ->
            IO.puts("Task Succeded: Miau")
        end
      end)

    _ref = Process.monitor(pid)

    receive do
      {:DOWN, _ref, :process, _object, :failure} ->
        IO.puts("Task Failed")
        schedule(args)

      _ ->
        nil
    end
  end
end
