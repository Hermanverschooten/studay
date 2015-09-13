defmodule Studay.Student do
  use Studay.Web, :model
  import Ecto.Query

  schema "students" do
    field :firstname, :string
    field :lastname, :string
    field :telephone, :string
    field :email, :string
    field :gender, :boolean

    timestamps
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
    |> update_change(:telephone, fn(x) -> String.replace(x,~r/ |\./,"") end)
    |> validate_format(:email, ~r/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/)
    |> validate_format(:telephone, ~r/^(\+32|0)\d{9}$/)
  end

  def sorted(query) do
    from p in query,
    order_by: [p.lastname]
  end

  defmodule Queries do
    def letters do
      {:ok, result} =Ecto.Adapters.SQL.query(
        Studay.Repo,
        "select distinct UPPER(LEFT(lastname,1)) as l from students order by l",
        []
      )
      Enum.flat_map(result[:rows], fn(x) -> x end)
    end
  end
end
