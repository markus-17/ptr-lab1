# Ptr.Lab1

This README describes the tasks performed for the first Laboratory Work for **PTR** subject, Week 1.

## How to run this project?

In order to run this project you should first clone the repo.

## Printing Hello PTR to stdout

Open a terminal inside the cloned repo and run the following command.

```
iex -S mix
```

This above command will open the elixir repl with the modules from the project pre-loaded.

Execute the `hello` function in the following way.

```
iex(1)> Ptr.Lab1.hello(:print)
Hello PTR
:ok
```

## Running the unit and the doc tests

Execute the following command.

```
mix test
```

You should expect an output similar to the one below

```
Compiling 1 file (.ex)
Generated ptrlab1 app
..
Finished in 0.02 seconds (0.00s async, 0.02s sync)
1 doctest, 1 test, 0 failures

Randomized with seed 734929
```
