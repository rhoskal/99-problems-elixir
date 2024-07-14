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
  def last([_ | tail]), do: last(tail)
end
