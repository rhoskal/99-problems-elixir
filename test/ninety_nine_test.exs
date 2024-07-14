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

  test "[03] Should return the nth element of a list" do
    assert NinetyNine.element_at(-2, [1, 2]) == nil
    assert NinetyNine.element_at(0, [1, 2]) == nil
    assert NinetyNine.element_at(2, []) == nil
    assert NinetyNine.element_at(2, [1, 2]) == 2
    assert NinetyNine.element_at(2, ["a", "b", "c", "d", "e"]) == "b"
  end

  test "[04] Should return the number of elements in a list" do
    assert NinetyNine.my_length([]) == 0
    assert NinetyNine.my_length([1]) == 1
    assert NinetyNine.my_length(Enum.to_list(1..10)) == 10
  end
end
