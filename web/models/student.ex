defmodule Studay.Student do
  use Studay.Web, :model

  schema "students" do
    field :firstname, :string
    field :lastname, :string
    field :telephone, :string
    field :email, :string

    timestamps
  end

  @required_fields ~w(firstname lastname telephone email)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
