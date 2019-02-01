# OVO Utils

Common utilities used in Our Very Own Elixir projects.

# Utility Functions

## Concurrent Tasks

* `populate_map_with_concurrent_functions(functions, timeout)` - _Concurrently executes functions and returns the results in a map._

## Maps

* `transform_keys(map, transformation)` - _Applies a transformation function on map keys._
* `atomise_string_keys(map)` - _Converts string keys in maps to atoms._
* `stringify_atom_keys(map)` - _Converts all string keys in a map to atom keys._
* `camelize_string_keys(map)` - _Converts all string keys in a map to camel case._
* `snakify_string_keys(map)` - _Converts all string keys in a map to to snake case._

## Miscellaneous

* `apply_on_ok(tuple, function)` - _Applies a function to a value inside an {:ok | :error, value} tuple if atom is :ok, otherwise returns the tuple without applying the function._