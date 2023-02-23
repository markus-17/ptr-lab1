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
