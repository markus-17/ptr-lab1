defmodule Ptr.Lab1 do
  @moduledoc """
  Documentation for `Ptr.Lab1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Ptr.Lab1.hello()
      :hello_ptr

  """
  def hello(:print) do
    IO.puts("Hello PTR")
  end

  def hello() do
    :hello_ptr
  end
end
