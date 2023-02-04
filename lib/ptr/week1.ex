defmodule Ptr.Week1 do
  @moduledoc """
  Documentation for `Ptr.Week1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Ptr.Week1.hello()
      :hello_ptr

  """
  def hello(:print) do
    IO.puts("Hello PTR")
  end

  def hello() do
    :hello_ptr
  end
end
