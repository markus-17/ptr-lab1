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
