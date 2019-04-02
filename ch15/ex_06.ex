defmodule CatServer do
  def cat(scheduler) do
    send(scheduler, {:ready, self()})

    receive do
      {:cat, params, client} ->
        send(
          client,
          {:answer, params[:filepath], count_matches_in_file(params[:filepath], params[:pattern]),
           self()}
        )

        cat(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end

  def count_matches_in_file(filepath, pattern) do
    File.stream!(filepath)
    |> Enum.map(&count_matches(&1, pattern))
    |> Enum.sum()
  end

  def count_matches(str, pattern) do
    str
    |> String.split()
    |> Enum.filter(&(&1 == pattern))
    |> Enum.count()
  end
end

defmodule Scheduler do
  def run(module, func, to_process) do
    files = File.ls!(to_process[:dir]) |> Enum.map(&Path.join(to_process[:dir], &1))
    num_processes = length(files)

    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(files, to_process[:pattern], [])
  end

  defp schedule_processes(processes, files, pattern, results) do
    receive do
      {:ready, pid} when files != [] ->
        [next | tail] = files
        send(pid, {:cat, [filepath: next, pattern: pattern], self()})
        schedule_processes(processes, tail, pattern, results)

      {:ready, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), files, pattern, results)
        else
          results
        end

      {:answer, filepath, result, _pid} ->
        schedule_processes(processes, files, pattern, [{filepath, result} | results])
    end
  end
end

# to_process = List.duplicate(37, 20)
to_process = [dir: "tests", pattern: "cat"]

{time, result} =
  :timer.tc(
    Scheduler,
    :run,
    [CatServer, :cat, to_process]
  )

IO.puts(inspect(result))
IO.puts("\n #   time (s)")
:io.format("~.2f~n", [time / 1_000_000.0])
