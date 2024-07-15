defmodule NinetyNine do
  @moduledoc """
  Documentation for `NinetyNine`.
  """

  @doc """
  Problem 1

  Return the last element of a list.
  Note: equivalent native fn is `List.last/2`

  ## Examples

      iex> NinetyNine.last([1, 2, 3])
      3

  """
  @spec last(Enumerable.t()) :: term() | nil
  def last([]), do: nil
  def last([x]), do: x
  def last([_ | xs]), do: last(xs)

  @doc """
  Problem 2

  Find the second last element of a list.

  ## Examples

      iex> NinetyNine.second_last([1, 2, 3])
      2

  """
  @spec second_last(Enumerable.t()) :: term() | nil
  def second_last([]), do: nil
  def second_last([x, _]), do: x
  def second_last([_ | xs]), do: second_last(xs)

  @doc """
  Problem 3

  Find the nth element of a list. The first element in the list is number 1.
  Note: equivalent native fn is `List.insert_at/3`

  ## Examples

      iex> NinetyNine.element_at(1, [1, 2, 3])
      1

  """
  @spec element_at(integer(), Enumerable.t()) :: term() | nil
  def element_at(_, []), do: nil
  def element_at(n, [x | _]) when n == 1, do: x
  def element_at(n, [_ | xs]), do: element_at(n - 1, xs)

  @doc """
  Problem 4

  Find the number of elements in a list.
  Note: equivalent native fn is `Enum.count/1` or `Kernel.length/1`

  ## Examples

      iex> NinetyNine.my_length([1, 2, 3])
      3

  """
  @spec my_length(Enumerable.t()) :: non_neg_integer()
  def my_length([]), do: 0
  def my_length([_ | xs]), do: 1 + my_length(xs)

  @doc """
  Problem 5

  Reverse items in a list.
  Note: equivalent native fn is `Enum.reverse/1`

  ## Examples

      iex> NinetyNine.reverse([1, 2, 3])
      [3, 2, 1]

  """
  @spec reverse(Enumerable.t()) :: list()
  def reverse(xs), do: List.foldl(xs, [], fn x, acc -> [x | acc] end)

  @doc """
  Problem 6

  Determine if a list is a palindrome.

  ## Examples

      iex> NinetyNine.palindrome?(["a", "b", "a"])
      true

  """
  @spec palindrome?(Enumerable.t()) :: boolean()
  def palindrome?([]), do: true
  def palindrome?([_]), do: true

  def palindrome?([x | xs]),
    do: x == List.last(xs) and palindrome?(List.delete_at(xs, Enum.count(xs) - 1))

  @doc """
  Problem 7

  Flatten a nested list structure.
  Note: equivalent native fn is `List.flatten/1`

  ## Examples

      iex> NinetyNine.flatten([1, [2, 3]])
      [1, 2, 3]

  """
  @spec flatten(Enumerable.t()) :: list()
  def flatten([]), do: []
  def flatten([x | xs]), do: flatten(x) ++ flatten(xs)
  def flatten(x), do: [x]

  @doc """
  Problem 8

  Eliminate consecutive duplicates of list elements.
  Note: equivalent native fn is `Enum.dedup/1`

  ## Examples

      iex> NinetyNine.compress([1, 1, 2, 3, 4, 4])
      [1, 2, 3, 4]

  """
  @spec compress(Enumerable.t()) :: list()
  def compress([]), do: []

  def compress([head | tail]),
    do: [head] ++ compress(Enum.drop_while(tail, &(&1 == head)))

  @doc """
  Problem 9

  Pack consecutive duplicates of list elements into sublists.

  ## Examples

      iex> NinetyNine.pack(["a", "a", "b", "c", "c"])
      ["aa", "b", "cc"]

  """
  @spec pack(Enumerable.t()) :: [String.t()]
  def pack([]), do: []

  def pack(xs) do
    {matches, rest} = Enum.split_while(xs, &(&1 == List.first(xs)))
    [Enum.join(matches)] ++ pack(rest)
  end

  @doc """
  Problem 10

  Runs the "run-length" encoding data compression algorithm.
  Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.
  Note: equivalent native fn is `Enum.frequencies/1`

  ## Examples

      iex> NinetyNine.encode(["a", "a", "b", "c", "c"])
      %{"a" => 2, "b" => 1, "c" => 2}

  """
  @spec encode(Enumerable.t()) :: map()
  def encode(xs) do
    xs
    |> Enum.uniq()
    |> List.foldl(%{}, fn key, acc ->
      count = Enum.count(xs, &(&1 == key))

      case acc do
        %{^key => _} ->
          %{acc | key => count}

        %{} ->
          Map.put(acc, key, count)
      end
    end)
  end

  # # Recursive solution
  # def encode(xs) do
  #   encode_helper(xs, %{})
  # end
  # defp encode_helper([], acc), do: acc
  # defp encode_helper(xs, acc) do
  #   key = List.first(xs)
  #   {matches, rest} = Enum.split_with(xs, &(&1 == key))
  #   count = Enum.count(matches)

  #   case acc do
  #     %{^key => _} -> encode_helper(rest, %{acc | key => count})
  #     %{} -> encode_helper(rest, Map.put(acc, key, count))
  #   end
  # end

  @doc """
  Problem 11

  Runs the "run-length" encoding data compression algorithm.
  Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E..

  ## Examples

      iex> NinetyNine.encode_modified(["a", "a", "b", "c", "c"])
      [{:multiple_encode, "a", 2}, {:single_encode, "b"}, {:multiple_encode, "c", 2}]

  """
  @spec encode_modified(Enumerable.t()) :: [
          {:multiple_encode | :single_encode, term(), integer()}
        ]
  def encode_modified(xs) do
    xs
    |> encode()
    |> Map.to_list()
    |> Enum.map(fn {value, count} ->
      if count > 1 do
        {:multiple_encode, value, count}
      else
        {:single_encode, value}
      end
    end)
  end

  @doc """
  Problem 12

  Decode a run-length encoded list.

  ## Examples

      iex> NinetyNine.decode_modified([{:multiple_encode, "a", 2}, {:single_encode, "b"}, {:multiple_encode, "c", 2}])
      ["a", "a", "b", "c", "c"]

  """
  @spec decode_modified([
          {:multiple_encode | :single_encode, term(), integer()}
        ]) :: list()
  def decode_modified([]), do: []
  def decode_modified([{:single_encode, val} | rest]), do: [val] ++ decode_modified(rest)

  def decode_modified([{:multiple_encode, val, count} | rest]),
    do: List.duplicate(val, count) ++ decode_modified(rest)

  @doc """
  Problem 13

  Run-length encoding of a list (direct solution).
  Implement the so-called run-length encoding data compression method directly.

  ## Examples

      iex> NinetyNine.encode_direct([1, 1, 2, 3, 3])
      [{:multiple_encode, 1, 2}, {:single_encode, 2}, {:multiple_encode, 3, 2}]

  """
  @spec encode_direct(Enumerable.t()) :: [
          {:multiple_encode | :single_encode, term(), integer()}
        ]
  def encode_direct([]), do: []

  def encode_direct(xs) do
    current = List.first(xs)
    {matches, rest} = Enum.split_with(xs, &(&1 == current))
    count = Enum.count(matches)

    encoded =
      case count == 1 do
        true -> {:single_encode, current}
        false -> {:multiple_encode, current, count}
      end

    [encoded] ++ encode_direct(rest)
  end

  @doc """
  Problem 14

  Duplicate each item in a given list.
  Note: equivalent native fn is `List.duplicate/2`

  ## Examples

      iex> NinetyNine.duplicate([1, 2, 3])
      [1, 1, 2, 2, 3, 3]

  """
  @spec duplicate(Enumerable.t()) :: list()
  def duplicate([]), do: []
  def duplicate([head | tail]), do: [head, head] ++ duplicate(tail)

  @doc """
  Problem 15

  Replicate each item in a given list n number of times.
  Note: equivalent native fn is `List.duplicate/2`

  ## Examples

      iex> NinetyNine.replicate([1, 2, 3], 3)
      [1, 1, 1, 2, 2, 2, 3, 3, 3]

  """
  @spec replicate(Enumerable.t(), integer()) :: list()
  def replicate([], _), do: []
  def replicate([head | tail], n), do: List.duplicate(head, n) ++ replicate(tail, n)

  @doc """
  Problem 16

  Drop every nth item in a given list.
  Note: equivalent native fn is `Enum.drop_every/2`

  ## Examples

      iex> NinetyNine.drop_every([1, 2, 3, 4, 5, 6, 7], 2)
      [1, 3, 5, 7]

  """
  @spec drop_every(Enumerable.t(), integer()) :: list()
  def drop_every([], _), do: []
  def drop_every(xs, n), do: Enum.take(xs, n - 1) ++ drop_every(Enum.drop(xs, n), n)

  @doc """
  Problem 17

  Splits a list into two parts; the length of the first part is given.
  Note: equivalent native fn is `Enum.split/2`

  ## Examples

      iex> NinetyNine.split([1, 2, 3, 4, 5, 6, 7], 2)
      {[1, 2], [3, 4, 5, 6, 7]}

  """
  @spec split(Enumerable.t(), integer()) :: {list(), list()}
  def split(xs, n) when n <= 0, do: {[], xs}
  def split(xs, n), do: {Enum.take(xs, n), Enum.drop(xs, n)}

  @doc """
  Problem 18

  Given two indices, i and k, the slice is the list containing the elements between
  the i'th and k'th element of the original list (both limits included).
  Start counting the elements with 1.
  Note: equivalent native fn is `Enum.slice/3`

  ## Examples

      iex> NinetyNine.slice([1, 2, 3, 4, 5, 6, 7], 2, 6)
      [2, 3, 4, 5, 6]

  """
  @spec slice(Enumerable.t(), integer(), integer()) :: list()
  def slice(_, start, stop) when stop <= start, do: []
  def slice(xs, start, stop), do: Enum.drop(xs, start - 1) |> Enum.take(stop - start + 1)

  @doc """
  Problem 19

  Rotate a list n places to the left.

  ## Examples

      iex> NinetyNine.rotate([1, 2, 3, 4, 5, 6, 7], 2)
      [3, 4, 5, 6, 7, 1, 2]

  """
  @spec rotate(Enumerable.t(), integer()) :: list()
  def rotate(xs, n) when n < 0,
    do: Enum.drop(xs, n + Enum.count(xs)) ++ Enum.take(xs, n + Enum.count(xs))

  def rotate(xs, n), do: Enum.drop(xs, n) ++ Enum.take(xs, n)

  @doc """
  Problem 20

  Removes the nth element from a list.
  Start counting the elements with 1.
  Note: equivalent native fn is `List.delete_at/2`

  ## Examples

      iex> NinetyNine.remove_at([1, 2, 3, 4, 5, 6, 7], 4)
      [1, 2, 3, 5, 6, 7]

  """
  @spec remove_at(Enumerable.t(), integer()) :: list()
  def remove_at(xs, n) when n < 0, do: xs
  def remove_at(xs, n), do: Enum.take(xs, n - 1) ++ Enum.drop(xs, n)

  @doc """
  Problem 21

  Inserts an element at the nth position.
  Start counting list elements with 0. If the position is larger or equal to
  the length of the list, insert the element at the end.
  (The behavior is unspecified if the position is negative.)

  ## Examples

      iex> NinetyNine.insert_at(9, [1, 2, 3, 4, 5, 6, 7], 4)
      [1, 2, 3, 4, 9, 5, 6, 7]

  """
  @spec insert_at(term(), Enumerable.t(), integer()) :: list()
  def insert_at(_, xs, n) when n < 0, do: xs
  def insert_at(val, xs, n) when n > length(xs), do: xs ++ [val]
  def insert_at(val, xs, n), do: Enum.take(xs, n) ++ [val] ++ Enum.drop(xs, n)

  @doc """
  Problem 22

  Create a list containing all integers within a given range.

  ## Examples

      iex> NinetyNine.range(1, 5)
      [1, 2, 3, 4, 5]

  """
  @spec range(integer(), integer()) :: list()
  def range(start, stop) when stop < start, do: []
  def range(start, stop), do: [start] ++ range(start + 1, stop)

  @doc """
  Problem 23

  Extract a given number of randomly selected elements from a list.
  It's not clear if duplicates are allowed.

  ## Examples

      iex> NinetyNine.rnd_select([1, 2, 3, 4, 5], 2)

  """
  @spec rnd_select(list(), integer()) :: list()
  def rnd_select(_, 0), do: []
  def rnd_select([], _), do: []

  def rnd_select(xs, n) do
    random = :rand.uniform(length(xs) - 1)

    [Enum.fetch!(xs, random)] ++ rnd_select(xs, n - 1)
  end

  @doc """
  Problem 24

  Extract n different random numbers from the set 1..M.

  ## Examples

      iex> NinetyNine.lotto_select(2, 5)

  """
  @spec lotto_select(integer(), integer()) :: list()
  def lotto_select(n, m), do: rnd_select(Enum.to_list(1..m), n)

  @doc """
  Problem 25

  Generate a random permutation of the elements of a list.
  Note: this solution does not guarantee uniqueness (distinct elements) from `as`

  ## Examples

      iex> NinetyNine.rnd_permutations([1, 2, 3, 4])

  """
  @spec rnd_permutations(Enumerable.t()) :: [term()]
  def rnd_permutations([]), do: []
  def rnd_permutations(xs), do: rnd_select(xs, Enum.count(xs))

  @doc """
  Problem 26

  Generate combinations of k distinct objects chosen from the n elements of a list.

  ## Examples

      iex> NinetyNine.combinations(1, [1, 2, 3, 4])
      [[1], [2], [3], [4]]

  """
  @spec combinations(integer(), Enumerable.t()) :: [[term()]]
  def combinations(0, _), do: [[]]

  def combinations(n, xs) when n > 0 do
    for i <- 0..(length(xs) - n),
        x <- combinations(n - 1, Enum.drop(xs, i + 1)),
        do: [Enum.at(xs, i) | x]
  end

  @doc """
  Problem 27

  Group the elements of a set into 3 disjoint subsets.

  ## Examples

      iex> NinetyNine.group3([1, 2, 3, 4])
      [ [[1, 2, 3]],
        [[1, 2, 4]],
        [[1, 3, 4]],
        [[2, 3, 4]]
      ]

  """
  @spec group3(Enumerable.t()) :: [[[term()]]]
  def group3(xs), do: group([3], xs)

  @doc """
  Problem 28

  Generalized `group3` specifying a list of group sizes and the predicate will return a list of groups.

  ## Examples

      iex> NinetyNine.group([2, 1], ["a", "b", "c", "d"])
      [ [["a", "b"], ["c"]],
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

  """
  @spec group([integer()], Enumerable.t()) :: [[[term()]]]
  def group([], _), do: [[]]

  def group([n | ns], xs) do
    for {g, rs} <- _combinations(n, xs),
        gs <- group(ns, rs),
        do: [g | gs]
  end

  @spec _combinations(integer(), Enumerable.t()) :: [[[term()]]]
  defp _combinations(0, xs), do: [{[], xs}]
  defp _combinations(_, []), do: []

  defp _combinations(n, [x | xs]) do
    selected =
      for {ys, zs} <- _combinations(n - 1, xs),
          do: {[x | ys], zs}

    remaining =
      for {ys, zs} <- _combinations(n, xs),
          do: {ys, [x | zs]}

    selected ++ remaining
  end

  @doc """
  Problem 29

  Sort the elements of a list according to their length.
  e.g. short lists first, longer lists later.

  ## Examples

      iex> NinetyNine.lsort(["4444", "333", "22", "1"])
      ["1", "22", "333", "4444"]

  """
  @spec lsort(Enumerable.t()) :: list()
  def lsort(list) do
    list
    |> Enum.group_by(&String.length/1)
    |> Map.to_list()
    |> Enum.map(fn {_len, matches} -> Enum.sort(matches) end)
    |> List.flatten()
  end

  @doc """
  Problem 30

  Sort the elements of a list according to their length frequency.
  e.g. in the default, where sorting is done ascendingly, lists with rare
  lengths are placed first, others with a more frequent length come later.

  ## Examples

      iex> NinetyNine.lfsort(["4444", "333", "333", "22", "1"])
      ["4444", "22", "1", "333", "333"]

  """
  @spec lfsort(Enumerable.t()) :: list()
  def lfsort(list) do
    list
    |> Enum.sort_by(&frequency(String.length(&1), list))
  end

  defp frequency(len, list) do
    list
    |> Enum.filter(&(String.length(&1) == len))
    |> length()
  end

  @doc """
  Problem 31

  Should return true if given number is prime.
  Note: uses "trivial division" which is the most basic algo.
  Optimizations: only check up to the sqrt n and skip evens after 2

  ## Examples

      iex> NinetyNine.prime?(2)
      true

  """
  @spec prime?(integer()) :: boolean()
  def prime?(n) when n < 2, do: false
  def prime?(n) when n == 2, do: true

  def prime?(n) do
    Stream.iterate(3, &(&1 + 2))
    |> Enum.take_while(&(&1 * &1 <= n))
    |> List.insert_at(0, 2)
    |> Enum.all?(&(rem(n, &1) != 0))
  end

  @doc """
  Problem 32

  Determine the prime factors of a given positive integer.
  Returns a flat list containing the prime factors in ascending order.

  ## Examples

      iex> NinetyNine.prime_factors(65)
      [5, 13]

  """
  @spec prime_factors(integer()) :: [integer()]
  def prime_factors(n), do: prime_factors_helper(n, 2)

  @spec prime_factors_helper(integer(), integer()) :: [integer()]
  defp prime_factors_helper(num, _divisor) when num == 1, do: []

  defp prime_factors_helper(num, divisor) when rem(num, divisor) == 0,
    do: [divisor | prime_factors_helper(div(num, divisor), divisor)]

  defp prime_factors_helper(num, divisor), do: prime_factors_helper(num, divisor + 1)

  @doc """
  Problem 33

  Determine the prime factors and their multiplicities of a given positive integer.

  ## Examples

      iex> NinetyNine.prime_factors_mult(65)
      [{5, 1}, {13, 1}]

  """
  @spec prime_factors_mult(integer()) :: [{integer(), integer()}]
  def prime_factors_mult(n),
    do:
      prime_factors(n)
      |> Enum.frequencies()
      |> Map.to_list()

  @doc """
  Problem 34

  Given a range of integers by its lower and upper limit, construct a list of all prime numbers in that range.

  ## Examples

      iex> NinetyNine.primes_from(5, 30)
      [5, 7, 11, 13, 17, 19, 23, 29]

  """
  @spec primes_from(integer(), integer()) :: [integer()]
  def primes_from(lower, upper),
    do:
      Enum.to_list(lower..upper)
      |> Enum.filter(&prime?/1)

  @doc """
  Problem 35

  Goldbach's conjecture - finds two prime numbers that sum up to a given even integer.

  ## Examples

      iex> NinetyNine.goldbach(30)
      {7, 23}

  """
  @spec goldbach(integer()) :: {integer(), integer()} | nil
  def goldbach(n),
    do:
      for(x <- primes_from(3, n - 2), y = n - x, prime?(y), do: {x, y})
      |> List.first()

  @doc """
  Problem 36

  Given a range of integers by its lower and upper limit, print a list of
  all even numbers and their Goldbach composition.

  ## Examples

      iex> NinetyNine.goldbach_list(3, 20)
      [ {4, {2, 2}},
        {6, {3, 3}},
        {8, {3, 5}},
        {10, {3, 7}},
        {12, {5, 7}},
        {14, {3, 11}},
        {16, {3, 13}},
        {18, {5, 13}},
        {20, {3, 17}}
      ]

  """
  @spec goldbach_list(integer(), integer()) :: [{integer(), {integer(), integer()}}]
  def goldbach_list(lower, upper) when upper < lower, do: []
  def goldbach_list(lower, _upper) when lower < 3, do: []

  def goldbach_list(lower, upper),
    do: for(i <- lower..upper, rem(i, 2) == 0, do: {i, goldbach(i)})

  # A solution that uses Elixir's Map which arguably could be a better
  # data structure to hold the resut
  # @spec goldbach_list(integer(), integer()) :: map()
  # def goldbach_list(lower, upper) do
  #   evens =
  #     Enum.to_list(lower..upper)
  #     |> Enum.filter(&(rem(&1, 2) == 0))

  #   goldbach_list_helper(evens, %{})
  # end

  # @spec goldbach_list_helper(Enumerable.t(), map()) :: map()
  # defp goldbach_list_helper([], acc), do: acc

  # defp goldbach_list_helper(evens, acc) do
  #   [key | rest] = evens
  #   gb = goldbach(key)

  #   case acc do
  #     %{^key => _} -> goldbach_list_helper(rest, %{acc | key => gb})
  #     %{} -> goldbach_list_helper(rest, Map.put(acc, key, gb))
  #   end
  # end
end
