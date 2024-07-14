defmodule NinetyNine do
  @moduledoc """
  Documentation for `NinetyNine`.
  """

  @doc """
  Problem 1

  Return the last element of a list.

  ## Examples

      iex> NinetyNine.last([1, 2, 3])
      3

  """
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
  def last_two([]), do: nil
  def last_two([x, y]), do: [x, y]
  def last_two([_ | xs]), do: last_two(xs)

  @doc """
  Problem 3

  Find the nth element of a list. The first element in the list is number 1.

  ## Examples

      iex> NinetyNine.element_at(1, [1, 2, 3])
      1

  """
  def element_at(_, []), do: nil
  def element_at(n, [x | _]) when n == 1, do: x
  def element_at(n, [_ | xs]), do: element_at(n - 1, xs)

  @doc """
  Problem 4

  Find the number of elements in a list.

  ## Examples

      iex> NinetyNine.my_length([1, 2, 3])
      3

  """
  def my_length([]), do: 0
  def my_length([_ | xs]), do: 1 + my_length(xs)

  @doc """
  Problem 5

  Reverse items in a list.

  ## Examples

      iex> NinetyNine.my_reverse([1, 2, 3])
      [3, 2, 1]

  """
  def my_reverse(xs), do: List.foldl(xs, [], fn x, acc -> [x | acc] end)
end
