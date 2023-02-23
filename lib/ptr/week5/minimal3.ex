defmodule Ptr.Week5.Minimal3 do
  def main do
    extracted_data = Ptr.Week5.Minimal2.main()
    {:ok, json} = Poison.encode(extracted_data)
    :ok = File.write("quotes.json", json)
    :ok
  end
end
