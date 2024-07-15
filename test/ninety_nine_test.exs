defmodule NinetyNineTest do
  use ExUnit.Case, async: true
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

  test "[05] Should return the elements in a list reversed" do
    assert NinetyNine.my_reverse([]) == []
    assert NinetyNine.my_reverse(Enum.to_list(1..5)) == [5, 4, 3, 2, 1]
  end

  test "[06] Should return true if a list is a palindrome" do
    assert NinetyNine.is_palindrome([]) == true
    assert NinetyNine.is_palindrome([1]) == true
    assert NinetyNine.is_palindrome([1, 2, 3]) == false
    assert NinetyNine.is_palindrome(["a", "b", "a"]) == true
    assert NinetyNine.is_palindrome([1, 2, 2, 1]) == true
    assert NinetyNine.is_palindrome(["x", "a", "m", "a", "x"]) == true
    assert NinetyNine.is_palindrome([1, 2, 4, 8, 16, 8, 4, 2, 1]) == true
  end

  test "[07] Should return a flattened list" do
    assert NinetyNine.flatten([1, [2, 3]]) == [1, 2, 3]
    assert NinetyNine.flatten(["a", ["b", ["c", "d"], "e"]]) == ["a", "b", "c", "d", "e"]
    assert NinetyNine.flatten([[["a"]]]) == ["a"]
  end

  test "[08] Should remove consecutive duplicates" do
    assert NinetyNine.compress(["a", "a", "b", "c", "c"]) == ["a", "b", "c"]

    assert NinetyNine.compress([
             "a",
             "a",
             "a",
             "a",
             "b",
             "c",
             "c",
             "a",
             "a",
             "d",
             "e",
             "e",
             "e",
             "e"
           ]) == ["a", "b", "c", "a", "d", "e"]
  end

  test "[09] Should pack/combine duplicates" do
    assert NinetyNine.pack(["a", "a", "b", "c", "c"]) == ["aa", "b", "cc"]
    assert NinetyNine.pack([1, 1, 2, 3, 3]) == ["11", "2", "33"]

    assert NinetyNine.pack(["a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]) ==
             ["aaaa", "b", "cc", "aa", "d", "eeee"]
  end

  test "[10] Should encode duplicates" do
    assert NinetyNine.encode(["a", "a", "b", "c", "c"]) == %{"a" => 2, "b" => 1, "c" => 2}
    assert NinetyNine.encode([1, 1, 2, 3, 3]) == %{1 => 2, 2 => 1, 3 => 2}
  end

  test "[11] Should encode duplicates but modified" do
    assert NinetyNine.encode_modified(["a", "a", "b", "c", "c"]) ==
             [{:multiple_encode, "a", 2}, {:single_encode, "b"}, {:multiple_encode, "c", 2}]

    assert NinetyNine.encode_modified([1, 1, 2, 3, 3]) ==
             [{:multiple_encode, 1, 2}, {:single_encode, 2}, {:multiple_encode, 3, 2}]
  end
end
