defmodule Studay.Game do
  use Studay.Web, :model

  schema "games" do
    field :name, :string
    field :type, :integer
    field :logo, :string
    field :active, :boolean, default: false
    field :max_time, :integer
    field :bonus, :integer

    timestamps

    has_many :scores, Studay.Score
  end

  @required_fields ~w(name type active max_time)
  @optional_fields ~w(bonus logo)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def active(query) do
    from p in query,
    where: p.active == true
  end

  def sorted(query) do
    from p in query,
    order_by: [p.name]
  end
end
