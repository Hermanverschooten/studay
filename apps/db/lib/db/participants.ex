defmodule Db.Participants do
  use Ecto.Schema
  import Ecto.Changeset
  alias Db.Participants

  @games 6

  schema "participants" do
    field :firstname, :string
    field :lastname, :string
    field :telephone, :string
    field :email, :string
    field :gender, Db.Gender, default: :male
    field :score, :integer
    field :games_to_play, :integer
    field :game_score, :integer, virtual: true
    timestamps
  end

  def add(params \\ %{}) do
    %Participants{}
    |> cast(params, [:firstname, :lastname, :telephone, :email, :gender])
    |> validate_required([:firstname, :lastname, :telephone, :email, :gender])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_change(:games_to_play, @games)
    |> put_change(:score, 0)
  end


  def add_game_played(participant, params \\ %{}) do
    participant
    |> cast(params, [:game_score])
    |> validate_required([:game_score])
    |> validate_number(:game_score, greater_than_or_equal_to: 0)
    |> calc_score
    |> dec_game_to_play
  end

  defp calc_score(changeset) do
    game_score = get_change(changeset, :game_score)
    score = get_field(changeset, :score)
    put_change(changeset, :score, score + game_score)
  end

  defp dec_game_to_play(changeset) do
    games_to_play = get_field(changeset, :games_to_play, @games)
    put_change(changeset, :games_to_play, dec_game(games_to_play))
  end

  defp dec_game(0), do: 0
  defp dec_game(gtp) when is_integer(gtp), do: gtp - 1
end
