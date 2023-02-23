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
