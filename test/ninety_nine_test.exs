defmodule NinetyNineTest do
  use ExUnit.Case
  doctest NinetyNine

  test "[01] Should return the last element of a list" do
    assert NinetyNine.last([]) == nil
    assert NinetyNine.last(["a"]) == "a"
    assert NinetyNine.last([1, 2, 3]) == 3
  end

  test "[02] Should return the last two elements of a list" do
    assert NinetyNine.last_two([]) == nil
    assert NinetyNine.last_two([true]) == nil
    assert NinetyNine.last_two([1, 2, 3]) == [2, 3]
  end
end
