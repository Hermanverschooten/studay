defmodule Studay.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :firstname, :string
      add :lastname, :string
      add :telephone, :string
      add :email, :string

      timestamps
    end

  end
end
