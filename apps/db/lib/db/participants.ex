defmodule Db.Participants do
  use Ecto.Schema
  import Ecto.Changeset
  alias Db.Participants

  schema "participants" do
    field :firstname, :string
    field :lastname, :string
    field :telephone, :string
    field :email, :string
    field :gender, Db.Gender, default: :male
    field :score, :integer, default: 0
    field :games_played, :integer, default: 0
    field :game_score, :integer, virtual: true
    timestamps
  end

  def add(params \\ %{}) do
    %Participants{}
    |> cast(params, [:firstname, :lastname, :telephone, :email, :gender])
    |> validate_required([:firstname, :lastname, :telephone, :email, :gender])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end


  def add_game_played(params \\ %{}) do
    %Participants{}
    |> cast(params, [:id, :game_score])
    |> validate_required([:id, :game_score])
    |> validate_number(:game_score, greater_than_or_equal_to: 0)
    |> calc_score
    |> inc_games_played
  end

  defp calc_score(changeset) do
    game_score = get_change(changeset, :game_score)
    score = get_field(changeset, :score)
    put_change(changeset, :score, score + game_score)
  end

  defp inc_games_played(changeset) do
    games_played = get_change(changeset, :games_played, 0)
    put_change(changeset, :games_played, games_played + 1)
  end
end
