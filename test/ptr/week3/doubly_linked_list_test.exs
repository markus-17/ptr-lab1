defmodule Ptr.Week3.DoublyLinkedListTest do
  use ExUnit.Case

  test "Test Doubly Linked List" do
    import Ptr.Week3.DoublyLinkedList

    select_values = fn {_, value} -> value end

    pid = start_right([1, 2, 3, 4])
    assert pid |> traverse_right() |> Enum.map(select_values) == [1, 2, 3, 4]

    pid |> append_left([20, 30, 40])
    {left_most, _} = pid |> traverse_left() |> List.last()
    assert left_most |> traverse_right() |> Enum.map(select_values) == [40, 30, 20, 1, 2, 3, 4]

    left_most |> append_right([15, 16, 17])
    {right_most, _} = left_most |> traverse_right() |> List.last()

    assert right_most |> traverse_left() |> Enum.map(select_values) == [
             17,
             16,
             15,
             4,
             3,
             2,
             1,
             20,
             30,
             40
           ]
  end
end
