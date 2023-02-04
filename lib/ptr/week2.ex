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
