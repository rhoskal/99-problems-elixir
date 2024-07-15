defmodule NinetyNineTest do
  use ExUnit.Case, async: true
  doctest NinetyNine

  test "[01] Should return the last element of a list" do
    assert NinetyNine.last([]) == nil
    assert NinetyNine.last(["a"]) == "a"
    assert NinetyNine.last([1, 2, 3]) == 3
  end

  test "[02] Should return the second last element of a list" do
    assert NinetyNine.second_last([]) == nil
    assert NinetyNine.second_last([true]) == nil
    assert NinetyNine.second_last([1, 2, 3]) == 2
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
    assert NinetyNine.reverse([]) == []
    assert NinetyNine.reverse(Enum.to_list(1..5)) == [5, 4, 3, 2, 1]
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
    assert NinetyNine.compress(["a", "a", "b", "c", "c"]) ==
             ["a", "b", "c"]

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
           ]) ==
             ["a", "b", "c", "a", "d", "e"]
  end

  test "[09] Should pack/combine duplicates" do
    assert NinetyNine.pack(["a", "a", "b", "c", "c"]) ==
             ["aa", "b", "cc"]

    assert NinetyNine.pack([1, 1, 2, 3, 3]) ==
             ["11", "2", "33"]

    assert NinetyNine.pack(["a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]) ==
             ["aaaa", "b", "cc", "aa", "d", "eeee"]
  end

  test "[10] Should encode duplicates" do
    assert NinetyNine.encode(["a", "a", "b", "c", "c"]) ==
             %{"a" => 2, "b" => 1, "c" => 2}

    assert NinetyNine.encode([1, 1, 2, 3, 3]) ==
             %{1 => 2, 2 => 1, 3 => 2}
  end

  test "[11] Should encode duplicates but modified" do
    assert NinetyNine.encode_modified(["a", "a", "b", "c", "c"]) == [
             {:multiple_encode, "a", 2},
             {:single_encode, "b"},
             {:multiple_encode, "c", 2}
           ]

    assert NinetyNine.encode_modified([1, 1, 2, 3, 3]) == [
             {:multiple_encode, 1, 2},
             {:single_encode, 2},
             {:multiple_encode, 3, 2}
           ]
  end

  test "[12] Should decode encoded duplicates" do
    assert NinetyNine.decode_modified([
             {:multiple_encode, "a", 2},
             {:single_encode, "b"},
             {:multiple_encode, "c", 2}
           ]) ==
             ["a", "a", "b", "c", "c"]

    assert NinetyNine.decode_modified([
             {:multiple_encode, 1, 2},
             {:single_encode, 2},
             {:multiple_encode, 3, 2}
           ]) ==
             [1, 1, 2, 3, 3]
  end

  test "[13] Should encode duplicates directly" do
    assert NinetyNine.encode_direct(["a", "a", "b", "c", "c"]) == [
             {:multiple_encode, "a", 2},
             {:single_encode, "b"},
             {:multiple_encode, "c", 2}
           ]

    assert NinetyNine.encode_direct([1, 1, 2, 3, 3]) == [
             {:multiple_encode, 1, 2},
             {:single_encode, 2},
             {:multiple_encode, 3, 2}
           ]
  end

  test "[14] Should duplicate items in a list" do
    assert NinetyNine.duplicate([1, 2, 3]) ==
             [1, 1, 2, 2, 3, 3]

    assert NinetyNine.duplicate(["a", "b", "c"]) ==
             ["a", "a", "b", "b", "c", "c"]
  end

  test "[15] Should duplicate items in a listn n times" do
    assert NinetyNine.replicate([1, 2, 3], 3) ==
             [1, 1, 1, 2, 2, 2, 3, 3, 3]

    assert NinetyNine.replicate(["a", "b", "c"], 2) ==
             ["a", "a", "b", "b", "c", "c"]
  end

  test "[16] Should drop every nth item from a list" do
    assert NinetyNine.drop_every(Enum.to_list(1..7), 2) ==
             [1, 3, 5, 7]

    assert NinetyNine.drop_every(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"], 3) ==
             ["a", "b", "d", "e", "g", "h", "j", "k"]
  end

  test "[17] Should split a given list into 2 parts" do
    assert NinetyNine.split(Enum.to_list(1..10), 0) ==
             {[], Enum.to_list(1..10)}

    assert NinetyNine.split(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"], 3) ==
             {["a", "b", "c"], ["d", "e", "f", "g", "h", "i", "j", "k"]}
  end

  test "[18] Should slice a list given a range" do
    assert NinetyNine.slice(Enum.to_list(1..7), 2, 6) ==
             [2, 3, 4, 5, 6]

    assert NinetyNine.slice(Enum.to_list(1..7), 3, 1) ==
             []

    assert NinetyNine.slice(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"], 3, 7) ==
             ["c", "d", "e", "f", "g"]
  end

  test "[19] Should rotate a list" do
    assert NinetyNine.rotate(["a", "b", "c", "d", "e", "f", "g", "h"], 3) ==
             ["d", "e", "f", "g", "h", "a", "b", "c"]

    assert NinetyNine.rotate(["a", "b", "c", "d", "e", "f", "g", "h"], -2) ==
             ["g", "h", "a", "b", "c", "d", "e", "f"]
  end

  test "[20] Should remove nth element" do
    assert NinetyNine.remove_at(["a", "b", "c", "d"], 2) == ["a", "c", "d"]
    assert NinetyNine.remove_at(["a", "b", "c", "d"], -1) == ["a", "b", "c", "d"]
  end

  test "[21] Should insert at nth position" do
    assert NinetyNine.insert_at("X", ["a", "b", "c", "d"], 2) == ["a", "b", "X", "c", "d"]
    assert NinetyNine.insert_at("X", ["a", "b", "c", "d"], -1) == ["a", "b", "c", "d"]
    assert NinetyNine.insert_at("X", ["a", "b", "c", "d"], 99) == ["a", "b", "c", "d", "X"]
  end
end
