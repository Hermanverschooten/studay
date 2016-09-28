defmodule Db.GamesPlayed do
  use Ecto.Schema
  import Ecto.Changeset
  alias Db.GamesPlayed

  schema "games_played" do
    field :game, :string
    field :score, :integer
    field :data, :map
    timestamps
    belongs_to :participants, Db.Participants
  end

  def add(params \\ %{}) do
    %GamesPlayed{}
    |> cast(params, [:participants_id, :game, :score, :data])
    |> validate_required([:participants_id, :game, :score])
  end
end
