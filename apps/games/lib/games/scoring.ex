defmodule Games.Scoring do
  use GenServer

  defstruct name: "", type: :score, max: 1000


  # Public Interface
  def start_link(games) do
    GenServer.start_link(__MODULE__, games, name: :score)
  end

  def calc_score(game, score) do
    GenServer.call(:score, {:calc_score, game, score})
  end

  #Private Interface
  def init(games) do
    table = :ets.new(:games, [:set, :protected, :named_table])
    for game <- games do
      :ets.insert(:games, {game.name, game})
    end

    {:ok, table}
  end

  def handle_call({:calc_score, game, score}, _from ,state) do
    [{^game, game_info}] = :ets.lookup(:games, game)
    perc = case game_info.type do
      :score ->
        (score / game_info.max)
      :speed ->
        ((game_info.max - score) / game_info.max)
    end
    {:reply, Kernel.round(perc * 1000), state}
  end
end
