# FAF.PTR16.1 -- Project 0
> **Performed by:** Purici Marius, group FAF-202
> **Verified by:** asist. univ. Alexandru Osadcenco

## P0W1

**Task** -- Write a script that would print the message “Hello PTR” on the screen. Execute it.

```elixir
defmodule Ptr.Week1 do
  @moduledoc """
  Documentation for `Ptr.Week1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Ptr.Week1.hello()
      :hello_ptr

  """
  def hello(:print) do
    IO.puts("Hello PTR")
  end

  def hello() do
    :hello_ptr
  end
end
```

This is an Elixir module named `Ptr.Week1`. It contains two functions named `hello/0` and `hello/1`. The function `hello/0` returns an atom `:hello_ptr` when called. The function `hello/1` takes one argument and if the argument is the atom `:print`, it prints "Hello PTR" to the console. The module also includes documentation for itself and its functions using the `@moduledoc` and `@doc` attributes.

## P0W2

**All Tasks** - All the tasks in this laboratory work were done in a single module. Therefore, below you can see the entire module. The description for each task can be found in the `@doc`. A more detailed description can be found below the module.

```elixir
defmodule Ptr.Week2 do
  @doc """
  Function which determines whether an integer input is prime.
  
  ## Examples
  
    iex> Ptr.Week2.prime?(1)
    false
  
    iex> Ptr.Week2.prime?(2)
    true
  
    iex> Ptr.Week2.prime?(3)
    true
  
    iex> Ptr.Week2.prime?(4)
    false
  
    iex> Ptr.Week2.prime?(13)
    true
  
    iex> Ptr.Week2.prime?(91)
    false
  """
  def prime?(n) when n <= 1, do: false
  def prime?(n), do: prime?(n, 2)

  defp prime?(n, i) do
    cond do
      n == i -> true
      rem(n, i) == 0 -> false
      true -> prime?(n, i + 1)
    end
  end

  @doc """
  Write a function to calculate the area of a cylinder, given it's height and radius
  
  ## Examples
  
    iex> Ptr.Week2.cylinder_area(3, 4) |> Float.round(4)
    175.9292
  """
  def cylinder_area(h, r), do: 2 * :math.pi() * r * h + 2 * :math.pi() * r * r

  @doc """
  Write a function to reverse a list
  
  ## Examples
  
    iex> Ptr.Week2.reverse([1, 2, 4, 8, 4])
    [4, 8, 4, 2, 1]
  
    iex> Ptr.Week2.reverse([1, 2, 3, 4, 5])
    [5, 4, 3, 2, 1]
  """
  def reverse([]), do: []
  def reverse([head | tail]), do: reverse(tail) ++ [head]

  @doc """
  Write a function to calculate the sum of unique elements in a list.
  
  ## Examples
  
    iex> Ptr.Week2.unique_sum([1, 2, 4, 8, 4, 2])
    15
  
  """
  def unique_sum(list, n \\ 0)

  def unique_sum([], n), do: n

  def unique_sum([head | tail], n),
    do:
      unique_sum(
        tail,
        if head in tail do
          n
        else
          n + head
        end
      )

  @doc """
  Write a function that extracts n randomly select numbers.
  (For this task it is actually possible to use Enum.take_random/2, but just for the sake of doing the exercise I am only going to use Enum.random/1)
  """
  def extract_random_n(_list, 0), do: []

  def extract_random_n(list, n) do
    r = Enum.random(list)
    [r] ++ extract_random_n(list -- [r], n - 1)
  end

  @doc """
  Write a funciton that return the first n elements of the Fibonacci sequence.
  
  ## Examples
  
    iex> Ptr.Week2.fibonacci(7)
    [1, 1, 2, 3, 5, 8, 13]
  
    iex> Ptr.Week2.fibonacci(1)
    [1]
  
    iex> Ptr.Week2.fibonacci(2)
    [1, 1]
  
  """
  def fibonacci(n) when n > 0, do: fibonacci_helper(0, 1, n)
  defp fibonacci_helper(_a, _b, 0), do: []

  defp fibonacci_helper(a, b, n) do
    [b] ++ fibonacci_helper(b, a + b, n - 1)
  end

  @doc """
  Write a function that, given a dictionary, translates a sentence.
  
  ## Examples
  
    iex> Ptr.Week2.translator(%{"mama" => "mother", "papa" => "father"}, "mama is with papa")
    "mother is with father"
  
  """

  def translator(dictionary, string) do
    dictionary |> Enum.map(fn {k, v} -> [k, v] end) |> translator_helper(string)
  end

  defp translator_helper([], string), do: string

  defp translator_helper([[before, transformed] | tail], string) do
    translator_helper(tail, string |> String.replace(before, transformed))
  end

  @doc """
  Write a function that receives as input three digits and arranges them in an order that would create the smallest possibe number.
  
  ## Examples
  
    iex> Ptr.Week2.smallest_number(4, 5, 3)
    345
  
    iex> Ptr.Week2.smallest_number(0, 3, 4)
    304
  
  """
  def smallest_number(0, 0, 0), do: 0

  def smallest_number(a, b, c) do
    list = []

    list =
      list ++
        if a != 0 do
          [a]
        else
          []
        end

    list =
      list ++
        if b != 0 do
          [b]
        else
          []
        end

    list =
      list ++
        if c != 0 do
          [c]
        else
          []
        end

    list = Enum.sort(list)

    (list |> Enum.at(0)) * 100 +
      cond do
        length(list) == 1 -> 0
        length(list) == 2 -> list |> Enum.at(1)
        length(list) == 3 -> (list |> Enum.at(1)) * 10 + (list |> Enum.at(2))
      end
  end

  @doc """
  Write a function that would rotate a list n places to the left.
  
  ## Examples
  
    iex> Ptr.Week2.rotate_left([1, 2, 4, 8, 4], 3)
    [8, 4, 1, 2, 4]
  
    iex> Ptr.Week2.rotate_left([1, 2, 3, 4, 5, 6, 7, 8, 9], 4)
    [5, 6, 7, 8, 9, 1, 2, 3, 4]
  
  """
  def rotate_left(list, n) when list == [] or n == 0, do: list
  def rotate_left([head | tail], n) when n > 0, do: rotate_left(tail ++ [head], n - 1)

  @doc """
  
  ## Examples
  
    iex> Ptr.Week2.right_angle_triangles() |> Enum.all?(fn [a, b, c] -> a*a + b*b == c*c end)
    true
  
  """
  def right_angle_triangles() do
    list = for a <- 1..20, b <- 1..20, do: [a, b]
    right_angle_triangles_helper(list)
  end

  defp right_angle_triangles_helper([]), do: []

  defp right_angle_triangles_helper([[a, b] | tail]) do
    c = (a * a + b * b) |> :math.sqrt()

    if c - trunc(c) < 1.0e-7 do
      [[a, b, trunc(c)]]
    else
      []
    end ++ right_angle_triangles_helper(tail)
  end

  @doc """
  Write a function that eliminates consecutive duplicates in a list.
  
  ## Examples
  
    iex> Ptr.Week2.remove_consecutive_duplicates ([1, 2, 2, 2, 4, 8, 4])
    [1, 2, 4, 8, 4]
  
    iex> Ptr.Week2.remove_consecutive_duplicates ([1, 2, 2, 2, 4, 4, 4, 8, 4, 4])
    [1, 2, 4, 8, 4]
  
  """
  def remove_consecutive_duplicates(list) when length(list) <= 1, do: list

  def remove_consecutive_duplicates([head | tail]) do
    if head == hd(tail) do
      []
    else
      [head]
    end ++ remove_consecutive_duplicates(tail)
  end

  @doc """
  Write a function that, given an array of strings, will return the words that can be typed using one row of the QWERTY keyboard.
  
  ## Examples
  
    iex> Ptr.Week2.line_words(["Hello", "Alaska", "Dad", "Peace"])
    ["Alaska", "Dad"]
  
  """
  def line_words(words), do: Enum.filter(words, &line_word?(&1))

  def line_word?(word) do
    word = word |> String.downcase() |> String.split("", trim: true)

    ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(fn row -> Enum.map(word, fn char -> char in row end) end)
    |> Enum.map(&Enum.all?(&1))
    |> Enum.any?()
  end

  @doc """
  Function that encodes a string using the caesar cipher.
  
  ## Examples
  
    iex> Ptr.Week2.encode("lorem", 3)
    "oruhp"
  
    iex> Ptr.Week2.encode("zyzz", 2)
    "babb"
  
  """
  def encode(string, n) do
    alphabet_size = 26

    string
    |> String.downcase()
    |> to_charlist()
    |> Enum.map(&(&1 - ?a + n))
    |> Enum.map(&rem(&1, alphabet_size))
    |> Enum.map(
      &if &1 < 0 do
        &1 + alphabet_size
      else
        &1
      end
    )
    |> Enum.map(&(&1 + ?a))
    |> to_string()
  end

  @doc """
  Function that decodes a string using the caesar cipher.
  
  ## Examples
  
    iex> Ptr.Week2.decode("oruhp", 3)
    "lorem"
  
    iex> Ptr.Week2.decode("babb", 2)
    "zyzz"
  
  """
  def decode(string, n), do: encode(string, -n)

  @doc """
  Function which given a string of digits from 2 to 9 returns all possible letter combinations that those numbers could represent.any()
  
  ## Examples
  
    iex> Ptr.Week2.letter_combinations("2")
    ["a", "b", "c"]
  
    iex> Ptr.Week2.letter_combinations("23")
    ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
  
    iex> Ptr.Week2.letter_combinations("69")
    ["mw", "mx", "my", "mz", "nw", "nx", "ny", "nz", "ow", "ox", "oy", "oz"]
  
    iex> Ptr.Week2.letter_combinations("692")
    ["mwa", "mwb", "mwc", "mxa", "mxb", "mxc", "mya", "myb", "myc", "mza", "mzb", "mzc", "nwa", "nwb", "nwc", "nxa", "nxb", "nxc", "nya", "nyb", "nyc", "nza", "nzb", "nzc", "owa", "owb", "owc", "oxa", "oxb", "oxc", "oya", "oyb", "oyc", "oza", "ozb", "ozc"]
  
  """
  def letter_combinations(string) do
    dictionary = %{
      ?2 => 'abc',
      ?3 => 'def',
      ?4 => 'ghi',
      ?5 => 'jkl',
      ?6 => 'mno',
      ?7 => 'pqrs',
      ?8 => 'tuv',
      ?9 => 'wxyz'
    }

    letter_combinations_helper(string |> to_charlist, dictionary, [''])
    |> Enum.map(&to_string(&1))
  end

  defp letter_combinations_helper('', _dictionary, result), do: result

  defp letter_combinations_helper([head | tail], dictionary, result) do
    current = for list <- result, char <- dictionary[head], do: list ++ [char]
    letter_combinations_helper(tail, dictionary, current)
  end

  @doc """
  Write a function which given an array of string groups the anagrams together.
  
  ## Examples
  
    iex> Ptr.Week2.group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"])
    %{"aet" => ["eat", "tea", "ate"], "ant" => ["tan", "nat"], "abt" => ["bat"]}
  
  """
  def group_anagrams(strings), do: group_anagrams_helper(strings, %{})

  defp group_anagrams_helper([], result), do: result

  defp group_anagrams_helper([head | tail], result) do
    key = head |> to_charlist() |> Enum.sort() |> to_string()
    value = result |> Map.get(key, [])

    value =
      if head in value do
        value
      else
        value ++ [head]
      end

    result = result |> Map.put(key, value)

    group_anagrams_helper(tail, result)
  end

  @doc """
  Write a function to find the longest common prefix string amongst a list of strings.
  
    iex> Ptr.Week2.common_prefix(["flower", "flow", "flight"])
    "fl"
  
    iex> Ptr.Week2.common_prefix(["alpha", "beta", "gamma"])
    ""
  
  """
  def common_prefix([]), do: ""

  def common_prefix(strings) do
    {:ok, [substring, occurences]} =
      strings
      |> Enum.map(fn string -> [string, String.length(string) - 1] end)
      |> Enum.flat_map(fn [string, n] -> for i <- 0..n, do: String.slice(string, 0..i) end)
      |> Enum.group_by(& &1)
      |> Enum.map(fn {key, value} -> [key, length(value)] end)
      |> Enum.sort(fn [substring1, occurences1], [substring2, occurences2] ->
        if occurences1 == occurences2 do
          String.length(substring1) > String.length(substring2)
        else
          occurences1 > occurences2
        end
      end)
      |> Enum.fetch(0)

    if occurences == 1 do
      ""
    else
      substring
    end
  end

  @doc """
  Write a function to convert arabic numbers to roman numerals.
  
  ## Examples
  
    iex> Ptr.Week2.to_roman(13)
    "XIII"
  
    iex> Ptr.Week2.to_roman(1248)
    "MCCXLVIII"
  
  """
  def to_roman(number) do
    dict = [
      [1000, "M"],
      [900, "CM"],
      [500, "D"],
      [400, "CD"],
      [100, "C"],
      [90, "XC"],
      [50, "L"],
      [40, "XL"],
      [10, "X"],
      [9, "IX"],
      [5, "V"],
      [4, "IV"],
      [1, "I"]
    ]

    to_roman_helper(number, "", dict)
  end

  defp to_roman_helper(0, result, _dict), do: result

  defp to_roman_helper(number, result, dict) do
    [n, roman] = dict |> Enum.find(fn [n, _roman] -> number >= n end)
    to_roman_helper(number - n, result <> roman, dict)
  end

  @doc """
  Write a function to convert arabic numbers to roman numerals.
  
  ## Example
  
    iex> Ptr.Week2.factorize(13)
    [13]
  
  
    iex> Ptr.Week2.factorize(42)
    [2, 3, 7]
  
    iex> Ptr.Week2.factorize(460)
    [2, 2, 5, 23]
  
  """
  def factorize(number), do: factorize_helper(number, [])
  defp factorize_helper(1, result), do: result

  defp factorize_helper(n, result) do
    next_prime = 2..n |> Enum.find(fn i -> prime?(i) and rem(n, i) == 0 end)
    factorize_helper(div(n, next_prime), result ++ [next_prime])
  end
end
```

Here goes the explanation of the code from above:

* This code defines a function prime? that takes an integer n as input and returns a boolean value indicating whether n is a prime number or not. The function uses recursion to check if n is divisible by any integer from 2 to n-1. If it finds a divisor, it returns false, otherwise it returns true.

* This code defines a function cylinder_area that takes two arguments: h representing the height of a cylinder and r representing its radius. The function calculates and returns the surface area of the cylinder using the formula 2 * pi * r * h + 2 * pi * r^2.

* This code defines a function reverse that takes a list as input and returns a new list with the elements in reverse order. The function uses recursion to achieve this. It takes the first element of the input list (the head) and appends it to the end of the reversed tail (the rest of the list).

* This code defines a function unique_sum that takes a list as input and returns the sum of its unique elements. The function uses recursion to achieve this. It takes the first element of the input list (the head) and checks if it is present in the rest of the list (the tail). If it is not present, it adds its value to an accumulator n and calls itself with the tail and updated accumulator. If it is present, it simply calls itself with the tail and unchanged accumulator.

* This Elixir code defines a function extract_random_n/2 that takes in two arguments: a list and an integer n. The function extracts n randomly selected numbers from the input list and returns them in a new list. The function uses recursion to achieve this. It first selects a random element from the input list using Enum.random/1, then appends it to the result list and calls itself with the remaining elements of the input list and n-1. The base case for the recursion is when n is 0, in which case an empty list is returned.

* This Elixir code defines a function fibonacci/1 that takes in an integer n and returns the first n elements of the Fibonacci sequence in a list. The function uses recursion to achieve this. It calls a helper function fibonacci_helper/3 with initial arguments 0, 1, and n. The helper function then appends the second argument to the result list and calls itself with the second argument, the sum of the first two arguments, and n-1. The base case for the recursion is when n is 0, in which case an empty list is returned.

* This Elixir code defines a function translator/2 that takes in two arguments: a dictionary and a string. The function translates the input string using the given dictionary. It first converts the dictionary into a list of key-value pairs using Enum.map/2, then calls a helper function translator_helper/2 with this list and the input string. The helper function uses recursion to achieve this. It replaces each occurrence of the first element of the key-value pair in the input string with its corresponding value using String.replace/3, then calls itself with the remaining key-value pairs and the updated string. The base case for the recursion is when there are no more key-value pairs to process, in which case it returns the translated string.

* This Elixir code defines a function smallest_number/3 that takes in three digits as input and arranges them in an order that would create the smallest possible number. The function first creates an empty list and appends each non-zero digit to it. It then sorts the list in ascending order using Enum.sort/1. Finally, it calculates the smallest possible number by multiplying the first element of the sorted list by 100 and adding the remaining elements based on their position in the list.

* This Elixir code defines a function rotate_left/2 that takes in two arguments: a list and an integer n. The function rotates the input list n places to the left. The function uses recursion to achieve this. It first checks if the input list is empty or if n is 0, in which case it returns the input list. Otherwise, it removes the first element of the input list and appends it to the end using ++, then calls itself with this updated list and n-1. The base case for the recursion is when n is 0, in which case it returns the rotated list.

* This Elixir code defines a module with two functions: right_angle_triangles/0 and right_angle_triangles_helper/1. The first function generates a list of all possible pairs of integers from 1 to 20 and passes it to the second function. The second function takes this list as an argument and recursively checks if each pair can form the sides of a right-angled triangle with integer sides. If so, it returns a list containing the three sides of the triangle. Otherwise, it returns an empty list. The code also includes documentation for the right_angle_triangles/0 function with an example that tests if all returned triangles are indeed right-angled by checking if the square of the hypotenuse (the longest side) is equal to the sum of squares of the other two sides.

* This Elixir code defines a function remove_consecutive_duplicates/1 that takes a list as an argument and returns a new list with consecutive duplicates removed. The function is defined using pattern matching and recursion. The first definition of the function handles the base case where the input list has length less than or equal to 1. In this case, the function simply returns the input list. The second definition of the function handles the recursive case where the input list has more than one element. It uses pattern matching to split the input list into its head (first element) and tail (remaining elements). It then checks if the head is equal to the first element of the tail. If it is, it discards the head and calls itself recursively with only the tail as an argument. Otherwise, it keeps the head and concatenates it with a recursive call on only the tail. The code also includes documentation for this function with two examples that demonstrate how it removes consecutive duplicates from a given list.

* This Elixir code defines two functions: line_words/1 and line_word?/1. The first function takes a list of words as an argument and returns a new list containing only the words that can be typed using one row of the QWERTY keyboard. It does this by calling the second function on each word in the input list using the Enum.filter/2 function. The second function takes a single word as an argument and returns a boolean value indicating whether or not it can be typed using one row of the QWERTY keyboard. It does this by first converting the word to lowercase and splitting it into a list of characters. It then defines a list of three strings representing the three rows of keys on a QWERTY keyboard. It maps over this list to split each row into its individual keys and then maps over each row again to check if all characters in the input word are present in that row. Finally, it checks if any of these checks returned true. The code also includes documentation for the line_words/1 function with an example that demonstrates how it filters out words that cannot be typed using one row of the QWERTY keyboard.

* This Elixir code defines two functions: encode/2 and decode/2. The first function takes a string and an integer n as arguments and returns a new string that is the result of encoding the input string using the Caesar cipher with a shift of n. The second function takes a string and an integer n as arguments and returns a new string that is the result of decoding the input string using the Caesar cipher with a shift of n. The encode/2 function works by first converting the input string to lowercase and then splitting it into a list of characters. It then maps over this list to convert each character to its corresponding ASCII code and then adds n to this value. It then maps over this list again to take the remainder when dividing each value by 26 (the size of the alphabet) to ensure that it stays within the range of valid ASCII codes for lowercase letters. It then maps over this list again to handle negative values by adding 26 if necessary. Finally, it maps over this list one last time to convert each value back into its corresponding character and then concatenates these characters back into a single string. The decode/2 function simply calls the encode/2 function with -n instead of n, effectively reversing the encoding process. The code also includes documentation for both functions with examples that demonstrate how they encode and decode strings using the Caesar cipher.

* This Elixir code defines two functions: letter_combinations/1 and letter_combinations_helper/3. The first function takes a string of digits from 2 to 9 as an argument and returns a list of all possible letter combinations that those numbers could represent on a phone keypad. It does this by defining a dictionary that maps each digit to its corresponding letters on a phone keypad and then calling the second function with the input string converted to a list of characters, the dictionary, and an initial result list containing an empty string.

* The second function is defined using pattern matching and recursion. The first definition of the function handles the base case where the input string is empty. In this case, it simply returns the current result list. The second definition of the function handles the recursive case where the input string has at least one character. It uses pattern matching to split the input string into its head (first character) and tail (remaining characters). It then uses a nested for comprehension to generate all possible combinations of letters for this digit by concatenating each letter in its corresponding value in the dictionary with each element in the current result list. It then calls itself recursively with only the tail of the input string and this new result list as arguments. The code also includes documentation for the letter_combinations/1 function with several examples that demonstrate how it generates all possible letter combinations for different input strings.

* This Elixir code defines four functions: group_anagrams/1, group_anagrams_helper/2, common_prefix/0, and common_prefix/1. The first function takes a list of strings as an argument and returns a map where the keys are sorted versions of the input strings and the values are lists containing all input strings that are anagrams of each key. It does this by calling the second function with the input list and an initial empty map as arguments. The second function is defined using pattern matching and recursion. The first definition of the function handles the base case where the input list is empty. In this case, it simply returns the current result map. The second definition of the function handles the recursive case where the input list has at least one element. It uses pattern matching to split the input list into its head (first element) and tail (remaining elements). It then generates a key for this element by converting it to a list of characters, sorting it, and then converting it back into a string. It then retrieves any existing value for this key from the result map or an empty list if there is no such value. It then checks if this element is already in this value list and if not, adds it to this value list. Finally, it updates or inserts this key-value pair in the result map and calls itself recursively with only the tail of the input list and this new result map as arguments. The third function handles an edge case where there are no strings in which case it returns an empty string. The fourth function takes a non-empty list of strings as an argument and returns their longest common prefix. It does this by generating all possible substrings for each string in the input list starting from index 0 up to its length minus 1 using nested Enum.map/2 and for comprehensions. It then groups these substrings by their value using Enum.group_by/2 and maps over these groups to generate tuples containing each substring along with its number of occurrences across all strings in the input list using another Enum.map/2 comprehension. It then sorts these tuples first by their number of occurrences in descending order and then by their length in descending order using Enum.sort/2. Finally, it retrieves only its first tuple using Enum.fetch/2 which contains both its longest common substring across all strings in terms of length along with its number of occurrences across all strings in terms of count. If its number of occurrences equals 1 meaning that it occurs only once across all strings then it returns an empty string otherwise it returns its longest common substring. The code also includes documentation for both functions with examples that demonstrate how they group anagrams together into a map based on their sorted versions as keys along with how they find their longest common prefix amongst them.

* This Elixir code defines two functions: to_roman/1 and factorize/1. The first function converts an Arabic number to a Roman numeral. The second function returns the prime factors of a given number. Both functions have documentation with examples of their usage.

## P0W3

**Task 1** -- Doubly Linked List

```elixir
defmodule Ptr.Week3.DoublyLinkedList do
  @moduledoc """
  Module that would implement a doubly linked list where each node in the list is an actor.
  """

  def start_right([head | tail]) do
    pid = spawn(__MODULE__, :loop, [head, nil, nil])
    pid |> append_right(tail)
    pid
  end

  def start_left([head | tail]) do
    pid = spawn(__MODULE__, :loop, [head, nil, nil])
    pid |> append_left(tail)
    pid
  end

  def loop(value, left, right) do
    receive do
      {:append_right, values} when right != nil ->
        send(right, {:append_right, values})
        loop(value, left, right)

      {:append_right, [head | tail]} ->
        pid = spawn(__MODULE__, :loop, [head, self(), nil])
        send(pid, {:append_right, tail})
        loop(value, left, pid)

      {:append_right, []} ->
        loop(value, left, right)

      {:traverse_right, pid, ref, result} when right != nil ->
        send(right, {:traverse_right, pid, ref, result ++ [{self(), value}]})
        loop(value, left, right)

      {:traverse_right, pid, ref, result} ->
        send(pid, {:ok, ref, result ++ [{self(), value}]})
        loop(value, left, right)

      {:append_left, values} when left != nil ->
        send(left, {:append_left, values})
        loop(value, left, right)

      {:append_left, [head | tail]} ->
        pid = spawn(__MODULE__, :loop, [head, nil, self()])
        send(pid, {:append_left, tail})
        loop(value, pid, right)

      {:append_left, []} ->
        loop(value, left, right)

      {:traverse_left, pid, ref, result} when left != nil ->
        send(left, {:traverse_left, pid, ref, result ++ [{self(), value}]})
        loop(value, left, right)

      {:traverse_left, pid, ref, result} ->
        send(pid, {:ok, ref, result ++ [{self(), value}]})
        loop(value, left, right)
    end
  end

  def append_right(pid, values) do
    send(pid, {:append_right, values})
  end

  def traverse_right(pid) do
    ref = make_ref()
    send(pid, {:traverse_right, self(), ref, []})

    receive do
      {:ok, ^ref, result} ->
        result
    end
  end

  def append_left(pid, values) do
    send(pid, {:append_left, values})
  end

  def traverse_left(pid) do
    ref = make_ref()
    send(pid, {:traverse_left, self(), ref, []})

    receive do
      {:ok, ^ref, result} ->
        result
    end
  end
end
```

This Elixir code defines a module Ptr.Week3.DoublyLinkedList that implements a doubly linked list where each node in the list is an actor. The module provides functions to start a doubly linked list from either the left or right side (start_left/1 and start_right/1), append values to either side of the list (append_left/2 and append_right/2), and traverse the list in either direction (traverse_left/1 and traverse_right/1). The main logic of the module is contained in the loop/3 function which receives messages to perform these operations.

**Task 2** -- Queue

```elixir
defmodule Ptr.Week3.Queue do
  use Agent

  def start_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def push(value) do
    Agent.update(__MODULE__, fn state -> state ++ [value] end)
  end

  def pop() do
    Agent.get_and_update(
      __MODULE__,
      &case &1 do
        [head | tail] -> {head, tail}
        [] -> {nil, []}
      end
    )
  end
end
```

This is an Elixir module that defines a Queue data structure using an Agent process to manage its state. The Queue module has three public functions: start_link/0, push/1, and pop/0.

The start_link/0 function starts an Agent process with an initial state of an empty list and registers it with the name of the current module (__MODULE__). This allows other functions in the module to access the Agent’s state using its registered name.

The push/1 function takes a value as an argument and appends it to the end of the queue by updating the Agent’s state with a new list that includes the given value.

The pop/0 function retrieves and removes the first element from the queue. It does this by calling Agent.get_and_update/2, which retrieves the current state of the Agent and updates it based on a given function. In this case, if there are elements in the queue (i.e., if it is not empty), then it returns a tuple containing the first element (head) and updates its state to be a new list without that element (tail). If there are no elements in the queue (i.e., if it is empty), then it returns {nil, []}.

**Task 3** -- Scheduler

```elixir
defmodule Ptr.Week3.Scheduler do
  @doc """
  Create a module that would perform some risky business. When receiving a task to do, it will create a worker node
  that will perform the task. Given the nature of the task, the worker has 50% probability of failure. If the scheduler detects
  a crash, it will log it, and restart the worker node. If the worker node finishes successfully, it should print the result.
  """
  def schedule(args) do
    pid =
      spawn(fn ->
        case :rand.uniform(2) do
          1 ->
            Process.exit(self(), :failure)

          2 ->
            IO.puts("Task Succeded: Miau")
        end
      end)

    _ref = Process.monitor(pid)

    receive do
      {:DOWN, _ref, :process, _object, :failure} ->
        IO.puts("Task Failed")
        schedule(args)

      _ ->
        nil
    end
  end
end
```

This is an Elixir module that defines a Scheduler for performing “risky” tasks. The Scheduler module has one public function: schedule/1.

The schedule/1 function takes an argument (args) and spawns a new process to perform the task. The spawned process has a 50% probability of failure (determined by calling :rand.uniform(2)). If the process fails (i.e., if :rand.uniform(2) returns 1), it exits with a reason of :failure. If the process succeeds (i.e., if :rand.uniform(2) returns 2), it prints a success message.

After spawning the process, the schedule/1 function monitors it using Process.monitor/1. This allows it to receive a message if the monitored process exits. The function then enters a receive block to wait for messages. If it receives a message indicating that the monitored process exited with a reason of :failure, it logs the failure and calls itself recursively to restart the task with the same arguments (args). Otherwise, it does nothing.

**Task 4** -- Semaphore

```elixir
defmodule Ptr.Week3.Semaphore do
  @moduledoc """
  This module implements a semaphore.
  
  In order to test this module I recommend the following approach
  
  Open a terminal and type the following
  
      iex --sname cmd1@localhost -S mix
  
  Open a second terminal and type the following
  
      iex --sname cmd2@localhost -S mix
  
  Now, from the first node connect to the second node using the following code
  
      Node.connect(:"cmd2@localhost")
  
  You can check this from the second terminal using
  
      Node.list()
  
  From both terminals
  
      import Ptr.Week3.Semaphore
  
  From the first terminal create and register the semaphore process using
  
      semaphore = start_link(1)
      :global.register_name(:semaphore, semaphore)
  
  From the second terminal retrieve the pid of the registered semaphore using
  
      semaphore = :global.whereis_name(:semaphore)
  
  From the first terminal check the counter of the semaphore, acquire once, check again, acquire again
  
      semaphore |> get
      semaphore |> acquire
      semaphore |> get
      semaphore |> acquire
  
  The last call to acquire should block the node from the first terminal. Now, from the second terminal, check the counter, then release the semaphore
  
      semaphore |> get
      semaphore |> release
  
  After the call to release, you should see that the node from the first terminal was unblocked. You can check the counter of the semaphore again
  and you will see that the counter is still 0.
  
    semaphore |> get
  
  """

  def start_link(n) do
    pid = spawn_link(__MODULE__, :loop, [n, []])
    pid
  end

  def loop(current, blocked_processes) do
    receive do
      {:acquire, pid, ref} ->
        if current > 0 do
          send(pid, {:ok, ref})
          loop(current - 1, blocked_processes)
        else
          loop(current, blocked_processes ++ [{pid, ref}])
        end

      {:release} ->
        case blocked_processes do
          [head | tail] ->
            {pid, ref} = head
            send(pid, {:ok, ref})
            loop(current, tail)

          [] ->
            loop(current + 1, [])
        end

      {:get, pid, ref} ->
        send(pid, {:ok, ref, current})
        loop(current, blocked_processes)
    end
  end

  def acquire(semaphore) do
    ref = make_ref()
    send(semaphore, {:acquire, self(), ref})

    receive do
      {:ok, ^ref} -> true
    end
  end

  def release(semaphore) do
    send(semaphore, {:release})
    true
  end

  def get(semaphore) do
    ref = make_ref()
    send(semaphore, {:get, self(), ref})

    receive do
      {:ok, ^ref, current} ->
        current
    end
  end
end
```

This is an Elixir code for a module named Ptr.Week3.Semaphore that implements a semaphore. The module documentation provides instructions on how to test the module using two terminal windows and connecting them as nodes. The semaphore process can be created and registered from one terminal and its pid can be retrieved from the other terminal. The semaphore’s counter can be checked and manipulated using the acquire and release functions.

## P0W4

**Task 1** -- Car

```elixir
defmodule Ptr.Week4.Sensor do
  def loop(sensor_type) do
    IO.puts("A #{sensor_type} #{__MODULE__} started at #{inspect(self())}")

    receive do
      {:crash} ->
        IO.puts("The #{sensor_type} #{__MODULE__} at #{inspect(self())} sensor detected a crash.")
        exit(:crash)
    end
  end
end

defmodule Ptr.Week4.CarMonitor do
  def start_link do
    spawn_link(__MODULE__, :loop, [
      [
        {Ptr.Week4.Sensor, :loop, ["Cabin"]},
        {Ptr.Week4.Sensor, :loop, ["Motor"]},
        {Ptr.Week4.Sensor, :loop, ["Chassis"]}
      ] ++ (1..4 |> Enum.map(fn i -> {Ptr.Week4.Sensor, :loop, ["Wheel #{i}"]} end))
    ])
  end

  def loop(sensors_map) do
    sensors_map
    |> Enum.map(fn {module, start_fn, args} ->
      {_pid, ref} = spawn_monitor(module, start_fn, args)
      {ref, [{module, start_fn, args}, false]}
    end)
    |> loop_helper()
  end

  defp loop_helper(sensors_map) do
    crashed_sensors =
      sensors_map
      |> Enum.reduce(0, fn {_ref, [{_module, _start_fn, _args}, ever_crashed?]}, acc ->
        acc + if ever_crashed?, do: 1, else: 0
      end)

    if crashed_sensors > length(sensors_map) / 2 do
      IO.puts("\n\n!!! The Airbags were Activated !!!\n\n")

      sensors_map
      |> Enum.map(fn {ref, [{module, start_fn, args}, _ever_crashed]} ->
        {ref, [{module, start_fn, args}, false]}
      end)
      |> loop_helper()
    else
      receive do
        {:DOWN, old_ref, :process, _pid, _reason} ->
          {_ref, [{module, start_fn, args}, _ever_crashed?]} =
            sensors_map |> List.keyfind(old_ref, 0)

          {_pid, new_ref} = spawn_monitor(module, start_fn, args)

          new_sensors_map =
            List.keydelete(sensors_map, old_ref, 0) ++
              [{new_ref, [{module, start_fn, args}, true]}]

          loop_helper(new_sensors_map)
      end
    end
  end
end
```

This Elixir code defines two modules: Ptr.Week4.Sensor and Ptr.Week4.CarMonitor. The Sensor module has a loop function that receives a message of the form {:crash} and outputs a message indicating that the sensor detected a crash. The CarMonitor module has a start_link function that spawns linked processes for each sensor type. It also has a loop function that monitors the sensors and activates the airbags if more than half of the sensors have crashed.

**Task 2** -- Echoer

```elixir
defmodule Ptr.Week4.Echoer do
  def start_link(id) do
    pid = spawn_link(__MODULE__, :loop, [id, true])
    {:ok, pid}
  end

  def loop(id, first_time \\ false) do
    if first_time, do: IO.puts("The worker node with id #{id} has been started")

    receive do
      {:echo, message} ->
        IO.puts("Echo from worker node with id #{id}: #{message}")
        loop(id)

      {:die} ->
        IO.puts("The worker node with id #{id} has been killed")
        exit(:kill)
    end
  end

  def child_spec(id) do
    %{
      id: id,
      start: {__MODULE__, :start_link, [id]}
    }
  end
end

defmodule Ptr.Week4.EchoerSupervisor do
  use Supervisor

  def start_link(n) do
    Supervisor.start_link(__MODULE__, n, name: __MODULE__)
  end

  @impl true
  def init(n) do
    children = 1..n |> Enum.map(&Ptr.Week4.Echoer.child_spec(&1))
    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker(id) do
    {^id, pid, _, _} =
      __MODULE__
      |> Supervisor.which_children()
      |> Enum.find(fn {worker_id, _, _, _} -> worker_id == id end)

    pid
  end
end
```

This Elixir code defines two modules: Ptr.Week4.Echoer and Ptr.Week4.EchoerSupervisor. The Echoer module has a start_link function that spawns a linked process and returns its pid. It also has a loop function that receives messages of the form {:echo, message} and outputs the message or receives a message of the form {:die} and exits. The EchoerSupervisor module uses the Supervisor behaviour to start and supervise multiple instances of the Echoer module.

**Task 3** -- Processing Line

```elixir
defmodule Ptr.Week4.Splitter do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A #{__MODULE__} process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop do
    receive do
      {:split, string} ->
        splitted_strings = string |> String.split()

        IO.puts("#{__MODULE__} received \"#{string}\" and returned #{inspect(splitted_strings)}")

        Ptr.Week4.ProcessingLineSupervisor.get_worker("Nomster")
        |> send({:nomster, splitted_strings})

        loop()
    end
  end

  def child_spec do
    %{
      id: "Splitter",
      start: {__MODULE__, :start_link, []}
    }
  end
end

defmodule Ptr.Week4.Nomster do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A #{__MODULE__} process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop do
    receive do
      {:nomster, list} ->
        nomster_word = fn word ->
          word
          |> String.downcase()
          |> to_charlist()
          |> Enum.map(
            &case &1 do
              ?m ->
                ?n

              ?n ->
                ?m

              l ->
                l
            end
          )
          |> to_string()
        end

        nomstered_list = list |> Enum.map(nomster_word)

        IO.puts("#{__MODULE__} received #{inspect(list)} and returned #{inspect(nomstered_list)}")

        Ptr.Week4.ProcessingLineSupervisor.get_worker("Joiner")
        |> send({:join, nomstered_list})

        loop()
    end
  end

  def child_spec do
    %{
      id: "Nomster",
      start: {__MODULE__, :start_link, []}
    }
  end
end

defmodule Ptr.Week4.Joiner do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A #{__MODULE__} process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop do
    receive do
      {:join, list} ->
        joined_list = list |> Enum.join(" ")
        IO.puts("#{__MODULE__} received #{inspect(list)} and returned \"#{joined_list}\"")
        loop()
    end
  end

  def child_spec do
    %{
      id: "Joiner",
      start: {__MODULE__, :start_link, []}
    }
  end
end

defmodule Ptr.Week4.ProcessingLineSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    children = [
      Ptr.Week4.Splitter.child_spec(),
      Ptr.Week4.Nomster.child_spec(),
      Ptr.Week4.Joiner.child_spec()
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def get_worker(id) do
    {^id, pid, _, _} =
      __MODULE__
      |> Supervisor.which_children()
      |> Enum.find(fn {worker_id, _, _, _} -> worker_id == id end)

    pid
  end

  def send_message_to_pipeline(message) do
    get_worker("Splitter") |> send({:split, message})
  end
end
```

This Elixir code defines three modules: Ptr.Week4.Splitter, Ptr.Week4.Nomster, and Ptr.Week4.Joiner. The Splitter module has a start_link function that spawns a linked process and returns its pid. It also has a loop function that receives messages of the form {:split, string} and splits the string into a list of words. The list is then sent to the Nomster module for processing. The Nomster module has a similar structure to the Splitter module. Its loop function receives messages of the form {:nomster, list} and processes each word in the list by replacing all occurrences of “m” with “n” and vice versa. The processed list is then sent to the Joiner module for further processing. The Joiner module also has a similar structure to the Splitter and Nomster modules. Its loop function receives messages of the form {:join, list} and joins all elements in the list into a single string.

**Task 4** -- Pulp Fiction

```elixir
defmodule Ptr.Week4.WhiteActor do
  def loop do
    receive do
      {:ask, pid, ref, message} ->
        answer =
          case message do
            "What does Marsellus Wallace look like?" ->
              "What?"

            "What country you from?" ->
              "What?"

            "What ain't no country I ever heard of. They speak English in what?" ->
              "What?"

            "English motherfucker. Do you speak it?" ->
              "Yes"

            "Then you know what I'm saying" ->
              "Yes"

            "Describe what Marsellus Wallace looks like" ->
              "What?"

            "Say what again. Say what again. I dare you, not dare you, I double dare you motherfucker. Say what one more goddamn time." ->
              "He's black."

            "Go on." ->
              "He's bald."

            "Does he look like a bitch?" ->
              "What?"
          end

        freaks_out? = Enum.random(0..2) == 2
        if freaks_out?, do: exit(:freaked_out)
        Process.sleep(1_000)
        send(pid, {:answer, ref, answer})
        loop()
    end
  end
end

defmodule Ptr.Week4.BlackSupervisor do
  def start_link do
    questions = [
      "What does Marsellus Wallace look like?",
      "What country you from?",
      "What ain't no country I ever heard of. They speak English in what?",
      "English motherfucker. Do you speak it?",
      "Then you know what I'm saying",
      "Describe what Marsellus Wallace looks like",
      "Say what again. Say what again. I dare you, not dare you, I double dare you motherfucker. Say what one more goddamn time.",
      "Go on.",
      "Does he look like a bitch?"
    ]

    spawn_link(__MODULE__, :loop, [nil, questions])
  end

  def loop(nil, questions) do
    {pid, ref} = spawn_monitor(Ptr.Week4.WhiteActor, :loop, [])
    IO.puts("!!! Black Supervisor brought back White Actor !!!")
    loop({ref, pid}, questions)
  end

  def loop({_ref, pid}, []) do
    Process.exit(pid, :shoot)
    IO.puts("### Black supervisor shot White actor ###")
  end

  def loop({monitor_ref, pid}, [question | questions]) do
    question_ref = make_ref()
    send(pid, {:ask, self(), question_ref, question})
    IO.puts(">>> Black supervisor asked: #{question}")

    receive do
      {:DOWN, ^monitor_ref, :process, _pid, :freaked_out} ->
        IO.puts("??? White Actor freaked out ???")
        loop(nil, [question | questions])

      {:answer, ^question_ref, answer} ->
        IO.puts(">>> White Actor answered: #{answer}\n")
        loop({monitor_ref, pid}, questions)
    end
  end
end
```

This Elixir code defines two modules: Ptr.Week4.WhiteActor and Ptr.Week4.BlackSupervisor. The WhiteActor module has a loop function that receives messages of the form {:ask, pid, ref, message} and responds with an answer based on the message received. The answer is sent back to the sender using the provided pid and ref. The BlackSupervisor module has a start_link function that spawns a linked process and starts a loop with a list of questions. It also has two versions of the loop function. One version takes two arguments: nil and a list of questions. This version spawns a monitored process for the WhiteActor module and starts another loop with the reference and pid of the WhiteActor process and the list of questions.

## P0W5

**Task 1** -- Minimal 1

```elixir
defmodule Ptr.Week5.Minimal1 do
  def main do
    url = "https://quotes.toscrape.com/"
    {:ok, response} = HTTPoison.get(url)
    IO.puts("\nStatus Code:\n#{response.status_code}")

    headers_string =
      response.headers
      |> Enum.reduce("", fn {key, value}, acc -> acc <> "#{key}: #{value}" <> "\n" end)

    IO.puts("\nResponse Headers:\n#{headers_string}")
    IO.puts("\nResponse Body:\n#{response.body}")
  end
end
```

This code defines a module named Ptr.Week5.Minimal1 that has a main function. The main function does the following:

- It assigns the string "https://quotes.toscrape.com/" to the variable url.
- It uses the HTTPoison library to send a GET request to the url and stores the result in a tuple {:ok, response}.
- It prints a newline and the status code of the response using IO.puts.
- It converts the response headers, which are a list of key-value pairs, into a string by concatenating them with colons and newlines using Enum.reduce.
- It prints another newline and the headers string using IO.puts.
- It prints another newline and the response body using IO.puts.

**Task 2** -- Minimal 2

```elixir
defmodule Ptr.Week5.Minimal2 do
  def main do
    url = "https://quotes.toscrape.com/"
    {:ok, response} = HTTPoison.get(url)
    {:ok, html} = Floki.parse_document(response.body)

    quotes =
      html
      |> Floki.find(".text")
      |> Enum.map(fn {"span", [{"class", "text"}, {"itemprop", "text"}], [text]} -> text end)
      |> Enum.map(&String.slice(&1, 1..-2//1))

    authors =
      html
      |> Floki.find(".author")
      |> Enum.map(fn {"small", [{"class", "author"}, {"itemprop", "author"}], [text]} -> text end)

    extracted_data =
      Enum.zip(quotes, authors)
      |> Enum.map(fn {text, author} -> %{qoute: text, author: author} end)

    extracted_data
  end
end
```

This code defines a module called Ptr.Week5.Minimal2 that has a function called main. The function does the following steps:

- It assigns a URL of a website that contains quotes to a variable called url.
- It uses an HTTP client library called HTTPoison to send a GET request to the URL and store the response in another variable called response.
- It uses an HTML parser library called Floki to parse the response body into an HTML document and store it in another variable called html.
- It extracts all the elements with class .text from the HTML document using Floki.find and maps them to their text content using Enum.map. It also removes the first and last characters of each text using String.slice. It stores these texts in a variable called quotes.
- It extracts all the elements with class .author from the HTML document using Floki.find and maps them to their text content using Enum.map. It stores these texts in a variable called authors.
- It zips together the lists of quotes and authors using Enum.zip and maps each pair to a map with keys qoute (sic) and author using Enum.map. It stores these maps in a variable called extracted_data.
- It returns the value of extracted_data.

**Task 3** -- Minimal 3

```elixir
defmodule Ptr.Week5.Minimal3 do
  def main do
    extracted_data = Ptr.Week5.Minimal2.main()
    {:ok, json} = Poison.encode(extracted_data)
    :ok = File.write("quotes.json", json)
    :ok
  end
end
```

This  code defines a module called Ptr.Week5.Minimal3 that has a function called main. The function does the following steps:

- It calls the main function from the module Ptr.Week5.Minimal2 and stores the returned value in a variable called extracted_data. This value is a list of maps with keys qoute and author.
- It uses a JSON library called Poison to encode the extracted data into a JSON string and store it in another variable called json.
- It uses the built-in module File to write the JSON string to a file named “quotes.json” and store the result in another variable. The result is either :ok or an error tuple.
- It returns the value of :ok.

**Task Main** -- Main

```elixir
defmodule Ptr.Week5.DataBase do
  use Agent

  def start_link do
    Agent.start_link(
      fn ->
        {:ok, movies_json} = File.read("movies.json")
        {:ok, state} = Poison.decode(movies_json)
        state
      end,
      name: __MODULE__
    )
  end

  def get_all do
    Agent.get(__MODULE__, & &1)
  end

  def get_by_id(id) do
    Agent.get(__MODULE__, &Enum.find(&1, fn %{"id" => value} -> value == id end))
  end

  def create(title, release_year, director) do
    Agent.update(__MODULE__, fn state ->
      biggest_id =
        state
        |> Enum.reduce(-1, fn %{"id" => value}, acc -> if value > acc, do: value, else: acc end)

      state ++
        [
          %{
            "title" => title,
            "release_year" => release_year,
            "id" => biggest_id + 1,
            "director" => director
          }
        ]
    end)
  end

  def put(title, release_year, id, director) do
    Agent.update(__MODULE__, fn state ->
      Enum.filter(state, fn %{"id" => value} -> id != value end) ++
        [
          %{
            "title" => title,
            "release_year" => release_year,
            "id" => id,
            "director" => director
          }
        ]
    end)
  end

  def delete(id) do
    Agent.get_and_update(__MODULE__, fn state ->
      {
        state |> Enum.find(fn %{"id" => value} -> id == value end),
        state |> Enum.filter(fn %{"id" => value} -> id != value end)
      }
    end)
  end
end

defmodule Ptr.Week5.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/movies" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Ptr.Week5.DataBase.get_all() |> Poison.encode!())
  end

  get "/movies/:id" do
    movie =
      conn.path_params["id"]
      |> String.to_integer()
      |> Ptr.Week5.DataBase.get_by_id()

    case movie do
      nil ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(404, "Not Found")

      movie ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, movie |> Poison.encode!())
    end
  end

  post "/movies" do
    {:ok, body, conn} = conn |> Plug.Conn.read_body()

    {:ok,
     %{
       "title" => title,
       "release_year" => release_year,
       "director" => director
     }} = body |> Poison.decode()

    Ptr.Week5.DataBase.create(title, release_year, director)

    send_resp(conn, 201, "")
  end

  put "/movies/:id" do
    id =
      conn.path_params["id"]
      |> String.to_integer()

    {:ok, body, conn} = conn |> Plug.Conn.read_body()

    {:ok,
     %{
       "title" => title,
       "release_year" => release_year,
       "director" => director
     }} = body |> Poison.decode()

    Ptr.Week5.DataBase.put(title, release_year, id, director)

    send_resp(conn, 200, "")
  end

  delete "/movies/:id" do
    movie =
      conn.path_params["id"]
      |> String.to_integer()
      |> Ptr.Week5.DataBase.delete()

    case movie do
      nil ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(404, "Not Found")

      movie ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, movie |> Poison.encode!())
    end
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end

defmodule Ptr.Week5.Main do
  def run do
    {:ok, _} = Ptr.Week5.DataBase.start_link()
    IO.puts("The DataBase Agent has started")
    {:ok, _} = Plug.Cowboy.http(Ptr.Week5.Router, [])
    IO.puts("The server started on port 4000")
  end
end
```

This code defines two modules: Ptr.Week5.DataBase and Ptr.Week5.Router.

The module Ptr.Week5.DataBase uses an Agent to store and manipulate a list of movies that are read from a JSON file. It has the following functions:

- start_link: This function starts the agent with an initial state that is the list of movies decoded from the JSON file. It also names the agent with the module name.
- get_all: This function returns the current state of the agent, which is the list of movies.
- get_by_id: This function takes an id as an argument and returns the movie with that id from the list, or nil if not found.
- create: This function takes a title, a release year and a director as arguments and adds a new movie to the list with those attributes. It also assigns an id to the new movie by finding the biggest id in the list and adding one to it.
- put: This function takes a title, a release year, an id and a director as arguments and updates the movie with that id in the list with those attributes. If no movie with that id exists, it adds a new one to the list.
- delete: This function takes an id as an argument and removes the movie with that id from the list. It also returns the deleted movie or nil if not found.

The module Ptr.Week5.Router uses a Plug.Router to handle HTTP requests for movies. It has two routes:

- /movies: This route responds to GET requests by returning all movies in JSON format with status code 200. It also responds to POST requests by reading the request body and creating a new movie with the attributes from the body. It returns status code 201 and an empty response.
- /movies/:id: This route responds to GET requests by taking an id parameter from the path and returning the movie with that id in JSON format with status code 200, or “Not Found” in plain text with status code 404 if not found. It also responds to PUT requests by taking an id parameter from the path and updating the movie with that id with the attributes from the request body. It returns status code 200 and an empty response. It also responds to DELETE requests by taking an id parameter from the path and deleting the movie with that id. It returns status code 200 and the deleted movie in JSON format, or “Not Found” in plain text with status code 404 if not found.
- _: This route matches any other request and returns status code 404 and “Oops!” in plain text.

**Task Bonus** -- Bonus

```elixir
defmodule Ptr.Week5.Bonus do
  @doc """
    Ptr.Week5.Bonus.start_link
  """
  def start_link do
    {:ok, json} = File.read("spotify.json")

    {:ok,
     %{
       "refresh_token" => refresh_token,
       "client_id" => client_id,
       "client_secret" => client_secret,
       "user_id" => user_id
     }} = json |> Poison.decode()

    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
      HTTPoison.post(
        "https://accounts.spotify.com/api/token",
        "grant_type=refresh_token&refresh_token=#{refresh_token}&client_id=#{client_id}&client_secret=#{client_secret}&scope=ugc-image-upload playlist-modify-private playlist-modify-public user-read-email user-read-private",
        [{"Content-Type", "application/x-www-form-urlencoded"}]
      )

    {:ok, %{"access_token" => access_token}} = body |> Poison.decode()

    pid = spawn_link(__MODULE__, :loop, [access_token, user_id, nil])
    Process.register(pid, __MODULE__)
    pid
  end

  def loop(access_token, user_id, playlist_id) do
    receive do
      {:create_playlist, pid, ref, name, description} ->
        {:ok, %HTTPoison.Response{status_code: 201, body: body}} =
          HTTPoison.post(
            "https://api.spotify.com/v1/users/#{user_id}/playlists",
            %{name: name, description: description, public: true} |> Poison.encode!(),
            [{"Content-Type", "application/json"}, {"Authorization", "Bearer #{access_token}"}]
          )

        {:ok, %{"uri" => uri}} = body |> Poison.decode()
        [_, _, playlist_id] = uri |> String.split(":")
        send(pid, {:created, ref, playlist_id})
        loop(access_token, user_id, playlist_id)

      {:add_song, pid, ref, track_id} ->
        {:ok, %HTTPoison.Response{status_code: 201}} =
          HTTPoison.post(
            "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks?uris=spotify:track:#{track_id}",
            "",
            [{"Authorization", "Bearer #{access_token}"}]
          )

        send(pid, {:created, ref})
        loop(access_token, user_id, playlist_id)

      {:set_image, pid, ref, image_string} ->
        {:ok, %HTTPoison.Response{status_code: 202}} =
          HTTPoison.put(
            "https://api.spotify.com/v1/playlists/#{playlist_id}/images",
            image_string,
            [{"Authorization", "Bearer #{access_token}"}]
          )

        send(pid, {:ok, ref})
        loop(access_token, user_id, playlist_id)
    end
  end

  @doc """
    Ptr.Week5.Bonus.create_playlist("Test Playlist for Elixir", "Just a test Playlist for Elixir")
  """
  def create_playlist(name, description) do
    ref = make_ref()
    send(__MODULE__, {:create_playlist, self(), ref, name, description})

    receive do
      {:created, ^ref, playlist_id} ->
        playlist_id
    end
  end

  @doc """
    Ptr.Week5.Bonus.add_song("5iVyv5cB28Za3NbNnWHpry")
  """
  def add_song(track_id) do
    ref = make_ref()
    send(__MODULE__, {:add_song, self(), ref, track_id})

    receive do
      {:created, ^ref} ->
        :ok
    end
  end

  @doc """
    Ptr.Week5.Bonus.set_image("spotify.jpg")
  """
  def set_image(image_path) do
    {:ok, image} = File.read(image_path)
    image_string = image |> Base.encode64()
    ref = make_ref()
    send(__MODULE__, {:set_image, self(), ref, image_string})

    receive do
      {:ok, ^ref} ->
        :ok
    end
  end
end
```

This code defines a module called Ptr.Week5.Bonus that can create and update a Spotify playlist. It has the following functions:

- start_link: This function reads a JSON file with the Spotify credentials and requests an access token from the Spotify API. It then spawns and registers a process that runs the loop function with the access token, the user id and nil as arguments. It returns the process id of the spawned process.
- loop: This function takes an access token, a user id and a playlist id as arguments and waits for messages. It handles two types of messages:
  - {:create_playlist, pid, ref, name, description}: This message is sent by another process that wants to create a playlist with the given name and description. The function uses the access token to make a POST request to the Spotify API to create the playlist and get its uri. It extracts the playlist id from the uri and sends back a message to the sender with {:created, ref, playlist_id}. It then recurses with the same access token and user id but with the new playlist id.
  - {:add_song, pid, ref, track_id}: This message is sent by another process that wants to add a song with the given track id to the playlist. The function uses the access token and the playlist id to make a POST request to the Spotify API to add the song to the playlist. It sends back a message to the sender with {:added_song, ref}. It then recurses with same arguments.
  - {:set_image, pid, ref, image_string}: This message is sent by another process that wants to set an image for the playlist with the given image string. The function uses the access token and the playlist id to make a PUT request to the Spotify API to set the image for the playlist. It sends back a message to the sender with {:ok, ref}. It then recurses with same arguments.

## Conclusion

In this project, I have learned about various concepts and features of Elixir that enable concurrent and fault-tolerant programming. I have learned how to create and communicate with processes using spawn, send and receive. I have learned how to use GenServer and Agent abstractions to simplify state management and handle common patterns. I have learned how to link and monitor processes to detect failures and handle them appropriately. I have learned how to use Supervisor processes to define restart strategies for child processes. I have learned how to organize Supervisors into supervision trees that can be started as applications. Finally, I have learned how to work with Http in Elixir using libraries such as HTTPoison and Plug.

## Bibliography

1. https://elixir-lang.org/docs.html
2. https://elixir-lang.org/getting-started/processes.html
3. https://hexdocs.pm/elixir/1.13/GenServer.html
4. https://hexdocs.pm/elixir/main/Agent.html#content
5. https://hexdocs.pm/elixir/1.12/Supervisor.html
6. https://hexdocs.pm/httpoison/HTTPoison.html
7. https://hexdocs.pm/poison/Poison.html
8. https://hexdocs.pm/plug/readme.html
