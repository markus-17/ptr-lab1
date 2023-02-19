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
