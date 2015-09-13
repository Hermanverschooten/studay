defmodule Studay.Repo.Migrations.CreateScore do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :points, :integer
      add :data, :map
      add :game_id, references(:games)
      add :student_id, references(:students)

      timestamps
    end
    create index(:scores, [:game_id])
    create index(:scores, [:student_id])

  end
end
