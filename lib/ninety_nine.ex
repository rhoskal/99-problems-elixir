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
  @spec last([String.t() | Integer.t()]) :: [String.t() | Integer.t()]
  def last([]), do: nil
  def last([x]), do: x
  def last([_ | xs]), do: last(xs)

  @doc """
  Problem 2

  Find the last two (last and penultimate) elements of a list.

  ## Examples

      iex> NinetyNine.last_two([1, 2, 3])
      [2, 3]

  """
  @spec last_two([String.t() | Integer.t()]) :: [String.t() | Integer.t()]
  def last_two([]), do: nil
  def last_two([x, y]), do: [x, y]
  def last_two([_ | xs]), do: last_two(xs)

  @doc """
  Problem 3

  Find the nth element of a list. The first element in the list is number 1.
  Note: equivalent native fn is `List.insert_at/3`

  ## Examples

      iex> NinetyNine.element_at(1, [1, 2, 3])
      1

  """
  @spec element_at(Integer.t(), [String.t() | Integer.t()]) :: [String.t() | Integer.t()]
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
  @spec my_length([String.t() | Integer.t()]) :: Integer.t()
  def my_length([]), do: 0
  def my_length([_ | xs]), do: 1 + my_length(xs)

  @doc """
  Problem 5

  Reverse items in a list.
  Note: equivalent native fn is `Enum.reverse/1`

  ## Examples

      iex> NinetyNine.my_reverse([1, 2, 3])
      [3, 2, 1]

  """
  @spec my_reverse([String.t() | Integer.t()]) :: [String.t() | Integer.t()]
  def my_reverse(xs), do: List.foldl(xs, [], fn x, acc -> [x | acc] end)

  @doc """
  Problem 6

  Determine if a list is a palindrome.

  ## Examples

      iex> NinetyNine.is_palindrome(["a", "b", "a"])
      true

  """
  @spec is_palindrome([String.t() | Integer.t()]) :: [String.t() | Integer.t()]
  def is_palindrome([]), do: true
  def is_palindrome([_]), do: true

  def is_palindrome([x | xs]),
    do: x == List.last(xs) and is_palindrome(List.delete_at(xs, Enum.count(xs) - 1))

  @doc """
  Problem 7

  Flatten a nested list structure.
  Note: equivalent native fn is `List.flatten/1`

  ## Examples

      iex> NinetyNine.flatten([1, [2, 3]])
      [1, 2, 3]

  """
  @spec flatten([String.t() | Integer.t()]) :: [String.t() | Integer.t()]
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
  @spec compress([String.t() | Integer.t()]) :: [String.t() | Integer.t()]
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
  @spec pack([String.t() | Integer.t()]) :: [String.t()]
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
  @spec encode([String.t() | Integer.t()]) :: Map.t([String.t() | Integer.t()], Integer.t())
  def encode(xs) do
    xs
    |> Enum.uniq()
    |> List.foldl(%{}, fn key, acc ->
      count = Enum.count(xs, &(&1 == key))

      case acc do
        %{} -> Map.put(acc, key, count)
        _ -> %{acc | key => count}
      end
    end)
  end
end

