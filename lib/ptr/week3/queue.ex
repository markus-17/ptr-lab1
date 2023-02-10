defmodule Ptr.Week3.Queue do
  use Agent

  def start_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def push(value) do
    Agent.update(__MODULE__, fn state -> state ++ [value] end)
  end

  def pop() do
    Agent.get_and_update(
      __MODULE__,
      &case &1 do
        [head | tail] -> {head, tail}
        [] -> {nil, []}
      end
    )
  end
end
