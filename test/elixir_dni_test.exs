defmodule ElixirDniTest do
  use ExUnit.Case
  doctest ElixirDni

  test "Test valid NIE numbers" do
    valid_nies = ["Z1064764F", "X9263114W", "Y2387379Q"]
    Enum.each valid_nies, fn nie ->
      assert ElixirDni.valid?(nie) == true
      assert ElixirDni.id_type(nie) == :nie
    end
  end

  test "Test valid DNI numbers" do
    valid_dnis = ["94089778K", "46143359T", "73133450M"]
    Enum.each valid_dnis, fn dni ->
      assert ElixirDni.valid?(dni) == true
      assert ElixirDni.id_type(dni) == :dni
    end
  end

  test "Test invalid NIE numbers" do
    invalid_nies = ["X2217866J", "Y1217826K", "94089772K", "73133450J"]
    Enum.each invalid_nies, fn nie ->
      assert ElixirDni.valid?(nie) == false
    end
  end
end
