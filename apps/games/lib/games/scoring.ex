defmodule Games.Scoring do
  use GenServer

  # Public Interface
  def start(name, max \\ 1000) do
    GenServer.start_link(__MODULE__, max, name: name)
  end

  def calc_score(pid, score) do
    GenServer.call(pid, {:score, score})
  end

  #Private Interface
  def init(max) do

    {:ok, max}
  end

  def handle_call({:score, score}, _from ,state) do
    perc = (score / state)*100
    {:reply, perc, state}
  end
end
