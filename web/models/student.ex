defmodule Studay.Student do
  use Studay.Web, :model
  import Ecto.Query

  alias Studay.Score

  schema "students" do
    field :firstname, :string
    field :lastname, :string
    field :telephone, :string
    field :email, :string
    field :gender, :boolean

    timestamps

    has_many :scores, Studay.Score
    has_many :games, through: [:scores, :game]
    has_one :position, Studay.Position, foreign_key: :id
  end

  @required_fields ~w(firstname lastname telephone email gender)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> update_change(:email, &String.downcase/1)
    |> update_change(:lastname, &String.downcase/1)
    |> update_change(:firstname, &String.downcase/1)
    |> update_change(:telephone, fn(x) -> String.replace(x,~r/ |\./,"") end)
    |> validate_format(:email, ~r/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/)
    |> validate_format(:telephone, ~r/^(\+32|\+31|\+33|\+34|0)\d{9}$/)
  end

  def sorted(query) do
    from p in query,
    order_by: [p.lastname]
  end

  def count_scores(query, max_games) do
    from p in query,
    group_by: p.id,
    left_join: c in assoc(p, :scores),
    having: count(c.id) == ^max_games,
    select: {p, count(c.id)}
  end

  def with_position(query) do
    from p in query,
    join: c in assoc(p, :position),
    select: {p, c.position}
  end
end
