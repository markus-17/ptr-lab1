defmodule Ptr.Week4.Splitter do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A #{__MODULE__} process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop do
    receive do
      {:split, string} ->
        splitted_strings = string |> String.split()

        IO.puts("#{__MODULE__} received \"#{string}\" and returned #{inspect(splitted_strings)}")

        Ptr.Week4.ProcessingLineSupervisor.get_worker("Nomster")
        |> send({:nomster, splitted_strings})

        loop()
    end
  end

  def child_spec do
    %{
      id: "Splitter",
      start: {__MODULE__, :start_link, []}
    }
  end
end

defmodule Ptr.Week4.Nomster do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A #{__MODULE__} process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop do
    receive do
      {:nomster, list} ->
        nomster_word = fn word ->
          word
          |> String.downcase()
          |> to_charlist()
          |> Enum.map(
            &case &1 do
              ?m ->
                ?n

              ?n ->
                ?m

              l ->
                l
            end
          )
          |> to_string()
        end

        nomstered_list = list |> Enum.map(nomster_word)

        IO.puts("#{__MODULE__} received #{inspect(list)} and returned #{inspect(nomstered_list)}")

        Ptr.Week4.ProcessingLineSupervisor.get_worker("Joiner")
        |> send({:join, nomstered_list})

        loop()
    end
  end

  def child_spec do
    %{
      id: "Nomster",
      start: {__MODULE__, :start_link, []}
    }
  end
end

defmodule Ptr.Week4.Joiner do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A #{__MODULE__} process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop do
    receive do
      {:join, list} ->
        joined_list = list |> Enum.join(" ")
        IO.puts("#{__MODULE__} received #{inspect(list)} and returned \"#{joined_list}\"")
        loop()
    end
  end

  def child_spec do
    %{
      id: "Joiner",
      start: {__MODULE__, :start_link, []}
    }
  end
end

defmodule Ptr.Week4.ProcessingLineSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    children = [
      Ptr.Week4.Splitter.child_spec(),
      Ptr.Week4.Nomster.child_spec(),
      Ptr.Week4.Joiner.child_spec()
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def get_worker(id) do
    {^id, pid, _, _} =
      __MODULE__
      |> Supervisor.which_children()
      |> Enum.find(fn {worker_id, _, _, _} -> worker_id == id end)

    pid
  end

  def send_message_to_pipeline(message) do
    get_worker("Splitter") |> send({:split, message})
  end
end
