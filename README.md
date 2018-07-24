# ElixirDni

**Hex package for validating Spanish national id numbers(DNI/NIE)**

Import the ElixirDni module and then, all methods expect input as a string:

```elixir
  dni = "94089778K"

  valid?(dni)
  => true

  id_type(dni)
  => :dni

  valid_check_letter(dni)
  => "K"
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_dni` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_dni, "~> 0.1.0"}
  ]
end
```
