defmodule Participants do
  use GenServer

  @type gender :: :male | :female
  defstruct id: UUID.uuid4(),
  firstname: "",
  lastname: "",
  gender: :male,
  email: "",
  score: 0,
  games_played: []

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :participants)
  end

  def list do
    GenServer.call(:participants, :list)
  end

  def sorted_list(sorter) do
    list() |> Enum.sort_by(sorter)
  end

  def add(firstname, lastname, gender, email) do
    GenServer.call(
      :participants,
      {
        :add,
        %Participants{
          id: UUID.uuid4(),
          firstname: firstname,
          lastname: lastname,
          gender: gender,
          email: email
        }
      }
    )
  end

  def get(key) do
    GenServer.call(:participants, {:get, key})
  end

  def add_game(key, %Games.PlayedGame{} = game) do
    GenServer.call(:participants, {:add_game, key, game})
  end

  def init(_opts) do
    :ets.new(__MODULE__, [:set, :protected, :named_table])
    {:ok, nil}
  end

  def handle_call(:list, _from, state) do
    list = get_list([], :ets.first(__MODULE__))
    {:reply,list ,state}
  end

  def handle_call({:add, %Participants{} = part}, _from, state) do
    :ets.insert(__MODULE__, { part.id, part})
    {:reply, part, state}
  end

  def handle_call({:get, key}, _from, state) do
    case :ets.lookup(__MODULE__, key) do
      [{^key, part}] -> {:reply, part, state}
      [] -> :error
    end
  end

  def handle_call({:add_game, key, game}, _from, state) do
    case :ets.lookup(__MODULE__, key) do
      [{^key, part}] ->
        new_part = part
                    |> Map.put(:score, part.score + game.score)
                    |> Map.put(:games, part.games_played ++ [game])
       :ets.insert(__MODULE__, {key, new_part})
       {:reply, new_part, state}
       [] -> :error
    end

  end

  defp get_list(acc, :"$end_of_table"), do: acc
  defp get_list(acc, key) do
    [{_key, part }] = :ets.lookup(__MODULE__, key)
    get_list(acc ++ [part], :ets.next(__MODULE__, key))
  end
end
