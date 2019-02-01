[![Hex.pm](https://img.shields.io/hexpm/v/ovo_utils.svg)](https://hex.pm/packages/ovo_utils) [![Build Status](https://travis-ci.org/jmargenberg/monok.svg?branch=master)](https://travis-ci.org/jmargenberg/monok) [![Coverage Status](https://coveralls.io/repos/github/ourveryown/ovo-utils/badge.svg?branch=master)](https://coveralls.io/github/ourveryown/ovo-utils?branch=master)

# OVO Utils

Common utilities used in Our Very Own Elixir projects.

# Installation

Add `{:ovo_utils, "~> 0.1.0"}` to your `deps` in mix.exs and run `mix deps.get`

# Documentation

Full documentation can be found at [HexDocs](https://hexdocs.pm/ovo_utils/api-reference.html).

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
