defmodule Db.Repo.Migrations.AddGamesPlayed do
  use Ecto.Migration

  def change do
    create table(:games_played) do
      add :game, :string
      add :participants_id, :integer
      add :score, :integer
      add :data, :jsonb

      timestamps

    end

    create unique_index(:games_played, [:game, :participants_id])
    create index(:games_played, [:game])

  end
end
