defmodule NinetyNineTest do
  use ExUnit.Case
  doctest NinetyNine

  test "[01] Should return the last element of a list" do
    assert NinetyNine.last([1, 2, 3]) == 3
  end
end
