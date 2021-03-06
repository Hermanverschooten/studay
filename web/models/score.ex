defmodule Studay.Score do
  use Studay.Web, :model

  schema "scores" do
    field :points, :integer
    field :data, :map
    belongs_to :game, Studay.Game
    belongs_to :student, Studay.Student

    timestamps
  end

  @required_fields ~w(points game_id student_id)
  @optional_fields ~w(data)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:game_id, name: :scores_game_student)
  end
end
