defmodule ElixirDni do
  @moduledoc """
  Validates Spanish national id numbers (DNI, NIE). Methods for id type, and to
  get the valid verification letter (the last letter of the number).
  """

  @id_types [{~r/\d{8}[a-zA-Z]{1}/, :dni},{~r/[XYZ]\d{7}[a-zA-Z]{1}/, :nie}]


  @doc """
    Returns :nie, :dni, or nil for vaild id numbers
  """
  @spec id_type(String.t) :: atom
  def id_type(dni) when is_binary(dni) do
    {_, type} = Enum.find(@id_types, {nil, :unknown}, fn {reg, type} ->
      String.match?(dni, reg)
    end)
    type
  end

  defp nie_letters do
    %{X: 0, Y: 1, Z: 2}
  end

  defp current_check_letter(dni) do
    dni
    |> String.last
    |> String.upcase
  end

  defp leading(dni) do
    dni
    |> String.first
    |> String.upcase
    |> String.to_atom
  end

  defp parse_digits(:dni, dni) do
    String.slice(dni, 0..-2)
  end

  defp parse_digits(:nie, dni) do
    ending = String.slice(dni, 1..-2)
    prefix = nie_letters()[leading(dni)] |> Integer.to_string
    Enum.join([prefix, ending])
  end

  defp calculate_check(dni) do
    type = id_type(dni)
    digits = parse_digits(type, dni)|> String.to_integer
    Integer.mod(digits, 23)
  end

  defp verifiers do
    %{
      0 => "T", 1 => "R", 2 => "W", 3 => "A", 4 => "G", 5 => "M",
      6 => "Y", 7 => "F", 8 => "P", 9 => "D", 10 => "X", 11 => "B",
      12 => "N",	13 => "J", 14 => "Z" ,15 => "S", 16 => "Q",
      17 => "V", 18 => "H", 19 => "L", 20 => "C", 21 => "K",	22 => "E"
    }
  end

  @doc """
    Returns what the correct verfication letter should be
  """
  @spec valid_check_letter(String.t) :: String.t
  def valid_check_letter(dni) when is_binary(dni) do
    result = Enum.filter verifiers(), fn {key, _value} ->
      key == calculate_check(dni)
    end
    result
    |> List.first
    |> elem(1)
  end

  @doc """
    Returns boolean to check for valid id number
  """
  @spec valid?(String.t) :: boolean
  def valid?(dni) do
    id_type(dni) in [:nie, :dni] && (current_check_letter(dni) == valid_check_letter(dni))
  end
end
