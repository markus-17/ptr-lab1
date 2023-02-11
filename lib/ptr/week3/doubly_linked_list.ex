defmodule Ptr.Week3.DoublyLinkedList do
  @moduledoc """
  Module that would implement a doubly linked list where each node in the list is an actor.
  """

  def start_right([head | tail]) do
    pid = spawn(__MODULE__, :loop, [head, nil, nil])
    pid |> append_right(tail)
    pid
  end

  def start_left([head | tail]) do
    pid = spawn(__MODULE__, :loop, [head, nil, nil])
    pid |> append_left(tail)
    pid
  end

  def loop(value, left, right) do
    receive do
      {:append_right, values} when right != nil ->
        send(right, {:append_right, values})
        loop(value, left, right)

      {:append_right, [head | tail]} ->
        pid = spawn(__MODULE__, :loop, [head, self(), nil])
        send(pid, {:append_right, tail})
        loop(value, left, pid)

      {:append_right, []} ->
        loop(value, left, right)

      {:traverse_right, pid, ref, result} when right != nil ->
        send(right, {:traverse_right, pid, ref, result ++ [{self(), value}]})
        loop(value, left, right)

      {:traverse_right, pid, ref, result} ->
        send(pid, {:ok, ref, result ++ [{self(), value}]})
        loop(value, left, right)

      {:append_left, values} when left != nil ->
        send(left, {:append_left, values})
        loop(value, left, right)

      {:append_left, [head | tail]} ->
        pid = spawn(__MODULE__, :loop, [head, nil, self()])
        send(pid, {:append_left, tail})
        loop(value, pid, right)

      {:append_left, []} ->
        loop(value, left, right)

      {:traverse_left, pid, ref, result} when left != nil ->
        send(left, {:traverse_left, pid, ref, result ++ [{self(), value}]})
        loop(value, left, right)

      {:traverse_left, pid, ref, result} ->
        send(pid, {:ok, ref, result ++ [{self(), value}]})
        loop(value, left, right)
    end
  end

  def append_right(pid, values) do
    send(pid, {:append_right, values})
  end

  def traverse_right(pid) do
    ref = make_ref()
    send(pid, {:traverse_right, self(), ref, []})

    receive do
      {:ok, ^ref, result} ->
        result
    end
  end

  def append_left(pid, values) do
    send(pid, {:append_left, values})
  end

  def traverse_left(pid) do
    ref = make_ref()
    send(pid, {:traverse_left, self(), ref, []})

    receive do
      {:ok, ^ref, result} ->
        result
    end
  end
end
