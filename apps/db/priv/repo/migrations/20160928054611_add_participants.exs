defmodule Db.Repo.Migrations.AddParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :firstname, :string
      add :lastname, :string
      add :telephone, :string
      add :email, :string
      add :gender, :boolean
      add :score, :integer
      add :games_to_play, :integer

      timestamps
    end
    create unique_index(:participants, [:email])
    create index(:participants, ["score DESC NULLS LAST"])
  end
end
