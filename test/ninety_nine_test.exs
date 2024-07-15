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
    assert NinetyNine.palindrome?([]) == true
    assert NinetyNine.palindrome?([1]) == true
    assert NinetyNine.palindrome?([1, 2, 3]) == false
    assert NinetyNine.palindrome?(["a", "b", "a"]) == true
    assert NinetyNine.palindrome?([1, 2, 2, 1]) == true
    assert NinetyNine.palindrome?(["x", "a", "m", "a", "x"]) == true
    assert NinetyNine.palindrome?([1, 2, 4, 8, 16, 8, 4, 2, 1]) == true
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

  test "[22] Should create an array with sequential elements given range" do
    assert NinetyNine.range(4, 9) == [4, 5, 6, 7, 8, 9]
    assert NinetyNine.range(5, 1) == []
    assert NinetyNine.range(1, 1) == [1]
  end

  test "[23] Should get random selection" do
    assert length(NinetyNine.rnd_select([1, 2, 3, 4, 5], 5)) == 5
  end

  test "[24] Should get random selection" do
    assert length(NinetyNine.lotto_select(6, 49)) == 6
  end

  test "[25] Should generate random permutation" do
    assert length(NinetyNine.rnd_permutations([1, 2, 3, 4, 5])) == 5
  end

  test "[26] Should generate combinations" do
    assert NinetyNine.combinations(0, ["a", "b", "c", "d"]) ==
             [[]]

    assert NinetyNine.combinations(1, ["a", "b", "c", "d"]) ==
             [["a"], ["b"], ["c"], ["d"]]

    assert NinetyNine.combinations(1, [1, 2, 3, 4]) ==
             [[1], [2], [3], [4]]

    assert NinetyNine.combinations(2, [1, 2, 3, 4]) ==
             [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]

    assert NinetyNine.combinations(3, ["a", "b", "c", "d", "e", "f"]) ==
             [
               ["a", "b", "c"],
               ["a", "b", "d"],
               ["a", "b", "e"],
               ["a", "b", "f"],
               ["a", "c", "d"],
               ["a", "c", "e"],
               ["a", "c", "f"],
               ["a", "d", "e"],
               ["a", "d", "f"],
               ["a", "e", "f"],
               ["b", "c", "d"],
               ["b", "c", "e"],
               ["b", "c", "f"],
               ["b", "d", "e"],
               ["b", "d", "f"],
               ["b", "e", "f"],
               ["c", "d", "e"],
               ["c", "d", "f"],
               ["c", "e", "f"],
               ["d", "e", "f"]
             ]
  end

  test "[27] Should return combinations of length 3" do
    assert length(
             NinetyNine.group3([
               "aldo",
               "beat",
               "carla",
               "david",
               "evi",
               "flip",
               "gary",
               "hugo",
               "ida"
             ])
           ) == 84

    assert length(NinetyNine.group3(Enum.to_list(1..6))) == 20

    assert NinetyNine.group3(Enum.to_list(1..4)) ==
             [[[1, 2, 3]], [[1, 2, 4]], [[1, 3, 4]], [[2, 3, 4]]]
  end

  test "[28] Should handle a generalized `group3`" do
    assert length(
             NinetyNine.group([2, 3, 4], [
               "aldo",
               "beat",
               "carla",
               "david",
               "evi",
               "flip",
               "gary",
               "hugo",
               "ida"
             ])
           ) == 1260

    assert length(
             NinetyNine.group([2, 2, 5], [
               "aldo",
               "beat",
               "carla",
               "david",
               "evi",
               "flip",
               "gary",
               "hugo",
               "ida"
             ])
           ) == 756

    assert NinetyNine.group([2, 1], ["a", "b", "c", "d"]) == [
             [["a", "b"], ["c"]],
             [["a", "b"], ["d"]],
             [["a", "c"], ["b"]],
             [["a", "c"], ["d"]],
             [["a", "d"], ["b"]],
             [["a", "d"], ["c"]],
             [["b", "c"], ["a"]],
             [["b", "c"], ["d"]],
             [["b", "d"], ["a"]],
             [["b", "d"], ["c"]],
             [["c", "d"], ["a"]],
             [["c", "d"], ["b"]]
           ]
  end

  test "[29] Should return elements sorted by length" do
    assert NinetyNine.lsort(["abc", "de", "fgh", "de", "ijkl", "mn", "o"]) ==
             ["o", "de", "de", "mn", "abc", "fgh", "ijkl"]
  end

  test "[30] Should return elements sorted by least frequency lengths first" do
    assert NinetyNine.lfsort(["abc", "de", "fgh", "de", "ijkl", "mn", "o"]) ==
             ["ijkl", "o", "abc", "fgh", "de", "de", "mn"]
  end

  test "[31] Should return true if given number is prime" do
    assert NinetyNine.prime?(0) == false
    assert NinetyNine.prime?(2) == true
    assert NinetyNine.prime?(4) == false
    assert NinetyNine.prime?(7) == true
    assert NinetyNine.prime?(17) == true
    assert NinetyNine.prime?(47) == true
    assert NinetyNine.prime?(223) == true
  end

  test "[32] Should calculate the prime factors" do
    assert NinetyNine.prime_factors(315) == [3, 3, 5, 7]
    assert NinetyNine.prime_factors(35) == [5, 7]
    assert NinetyNine.prime_factors(820) == [2, 2, 5, 41]
  end

  test "[33] Should calculate the prime factors and multiplicities" do
    assert NinetyNine.prime_factors_mult(315) == [{3, 2}, {5, 1}, {7, 1}]
    assert NinetyNine.prime_factors_mult(35) == [{5, 1}, {7, 1}]
    assert NinetyNine.prime_factors_mult(820) == [{2, 2}, {5, 1}, {41, 1}]
  end

  test "[34] Should return a list of primes within a range" do
    assert NinetyNine.primes_from(10, 20) == [11, 13, 17, 19]
    assert NinetyNine.primes_from(50, 100) == [53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
    assert length(NinetyNine.primes_from(2, 7920)) == 1000
  end
end
