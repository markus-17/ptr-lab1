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
