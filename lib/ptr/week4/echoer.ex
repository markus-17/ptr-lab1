defmodule Ptr.Week4.Echoer do
  def start_link(id) do
    pid = spawn_link(__MODULE__, :loop, [id, true])
    {:ok, pid}
  end

  def loop(id, first_time \\ false) do
    if first_time, do: IO.puts("The worker node with id #{id} has been started")

    receive do
      {:echo, message} ->
        IO.puts("Echo from worker node with id #{id}: #{message}")
        loop(id)

      {:die} ->
        IO.puts("The worker node with id #{id} has been killed")
        exit(:kill)
    end
  end

  def child_spec(id) do
    %{
      id: id,
      start: {__MODULE__, :start_link, [id]}
    }
  end
end

defmodule Ptr.Week4.EchoerSupervisor do
  use Supervisor

  def start_link(n) do
    Supervisor.start_link(__MODULE__, n, name: __MODULE__)
  end

  @impl true
  def init(n) do
    children = 1..n |> Enum.map(&Ptr.Week4.Echoer.child_spec(&1))
    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker(id) do
    {^id, pid, _, _} =
      __MODULE__
      |> Supervisor.which_children()
      |> Enum.find(fn {worker_id, _, _, _} -> worker_id == id end)

    pid
  end
end
