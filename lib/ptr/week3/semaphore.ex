defmodule Ptr.Week3.Semaphore do
  @doc """
  This module implements a semaphore.
  
  In order to test this module I recommend the following approach
  
  Open a terminal and type the following
  
      iex --sname cmd1@localhost -S mix
  
  Open a second terminal and type the following
  
      iex --sname cmd2@localhost -S mix
  
  Now, from the first node connect to the second node using the following code
  
      Node.connect(:"cmd2@localhost")
  
  You can check this from the second terminal using
  
      Node.list()
  
  From both terminals
  
      import Ptr.Week3.Semaphore
  
  From the first terminal create and register the semaphore process using
  
      semaphore = start_link(1)
      :global.register_name(:semaphore, semaphore)
  
  From the second terminal retrieve the pid of the registered semaphore using
  
      semaphore = :global.whereis_name(:semaphore)
  
  From the first terminal check the counter of the semaphore, acquire once, check again, acquire again
  
      semaphore |> get
      semaphore |> acquire
      semaphore |> get
      semaphore |> acquire
  
  The last call to acquire should block the node from the first terminal. Now, from the second terminal, check the counter, then release the semaphore
  
      semaphore |> get
      semaphore |> release
  
  After the call to release, you should see that the node from the first terminal was unblocked. You can check the counter of the semaphore again
  and you will see that the counter is still 0.
  
    semaphore |> get
  
  """

  def start_link(n) do
    pid = spawn_link(__MODULE__, :loop, [n, []])
    pid
  end

  def loop(current, blocked_processes) do
    receive do
      {:acquire, pid, ref} ->
        if current > 0 do
          send(pid, {:ok, ref})
          loop(current - 1, blocked_processes)
        else
          loop(current, blocked_processes ++ [{pid, ref}])
        end

      {:release} ->
        case blocked_processes do
          [head | tail] ->
            {pid, ref} = head
            send(pid, {:ok, ref})
            loop(current, tail)

          [] ->
            loop(current + 1, [])
        end

      {:get, pid, ref} ->
        send(pid, {:ok, ref, current})
        loop(current, blocked_processes)
    end
  end

  def acquire(semaphore) do
    ref = make_ref()
    send(semaphore, {:acquire, self(), ref})

    receive do
      {:ok, ^ref} -> true
    end
  end

  def release(semaphore) do
    send(semaphore, {:release})
    true
  end

  def get(semaphore) do
    ref = make_ref()
    send(semaphore, {:get, self(), ref})

    receive do
      {:ok, ^ref, current} ->
        current
    end
  end
end
