defmodule Ptr.Week3 do
  @doc """
  Create an actor that prints on the screen any messages it receives.
  
  ## Examples
  
    pid = Ptr.Week3.echo_actor_starter()
    # from this line of code you should expect to see your message printed
    send(pid, "some random message")
    # the following line stops the previously spawned process
    Process.exit(pid, :kill)
  
  """
  def echo_actor_starter(), do: spawn(fn -> echo_actor() end)

  defp echo_actor() do
    receive do
      message ->
        IO.puts(message)
        echo_actor()
    end
  end

  @doc """
  Create an actor that prints a response to any message it receives
  
  ## Examples
  
    pid = Ptr.Week3.echo_actor_improved_starter()
    send(pid, 33)             # After this you should expect to see 12 printed as output
    send(pid, "AbraCadabra")  # After this you should expect to see "abracadabra" as output
    send(pid, %{})            # After this you should expect to soo "I don't know how to HANDLE this!" as output
    Process.exit(pid, :kill)
  
  """
  def echo_actor_improved_starter(), do: spawn(fn -> echo_actor_improved() end)

  defp echo_actor_improved() do
    receive do
      message when is_integer(message) ->
        IO.puts(message + 1)

      message when is_bitstring(message) ->
        IO.puts(message |> String.downcase())

      _ ->
        IO.puts("I don't know how to HANDLE this!")
    end

    echo_actor_improved()
  end

  @doc """
  Create two actors, one monitoring the other. If the first actor stops the second actors gets a notification.
  
  ## Examples
  
    {pid1, pid2} = Ptr.Week3.two_actors_starter()
    Process.exit(pid1, :kill) # After this line, you should expect a message from the second process.
  
  """
  def two_actors_starter() do
    pid1 = spawn(fn -> first_actor() end)
    pid2 = spawn(fn -> second_actor(pid1) end)
    {pid1, pid2}
  end

  defp first_actor(), do: echo_actor()

  defp second_actor(pid) do
    _ref = Process.monitor(pid)
    second_actor_helper()
  end

  defp second_actor_helper() do
    receive do
      {:DOWN, _ref, :process, _pid, reason} ->
        IO.puts("The actor I monitor exited because #{reason}")

      _ ->
        IO.puts("I do not know how to response to this message.")
        second_actor_helper()
    end
  end

  @doc """
  Create an actor which receives numbers as messages and with each request prints out the current average.
  
  ## Examples
  
    pid = Ptr.Week3.start_averager()
    send(pid, 23)       # The current average is 23
    send(pid, 13)       # The current average is 18
    send(pid, 0)        # The current average is 12
    send(pid, 4)        # The current average is 10
  
  """
  def averager_starter(), do: spawn(fn -> averager() end)

  def averager(accumulator \\ 0, count \\ 0) do
    receive do
      value when is_integer(value) ->
        IO.puts("The current average is #{(accumulator + value) / (count + 1)}")
        averager(accumulator + value, count + 1)

      _ ->
        IO.puts("This actor responds only to integers")
        averager(accumulator, count)
    end
  end
end
