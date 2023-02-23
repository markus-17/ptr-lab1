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
