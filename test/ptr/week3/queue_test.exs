defmodule Ptr.Week3.QueueTest do
  use ExUnit.Case

  test "Test Fifo Queue" do
    Ptr.Week3.Queue.start_link()

    assert Ptr.Week3.Queue.pop() == nil

    Ptr.Week3.Queue.push(69)
    Ptr.Week3.Queue.push(420)
    Ptr.Week3.Queue.push(35)

    assert Ptr.Week3.Queue.pop() == 69
    assert Ptr.Week3.Queue.pop() == 420

    Ptr.Week3.Queue.push(118)

    assert Ptr.Week3.Queue.pop() == 35
    assert Ptr.Week3.Queue.pop() == 118
    assert Ptr.Week3.Queue.pop() == nil
  end
end
