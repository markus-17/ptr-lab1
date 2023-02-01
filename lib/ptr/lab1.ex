defmodule Ptr.Lab1 do
  @moduledoc """
  Documentation for `Ptr.Lab1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Ptr.Lab1.hello()
      :hello_world

  """
  def hello(:print) do
    IO.puts("Hello World!")
  end

  def hello() do
    :hello_world
  end
end
