defmodule Studay.Repo.Migrations.AddIndex do
  use Ecto.Migration

  def change do
    create unique_index(:scores, [:game_id, :student_id], name: :scores_game_student)
  end
end
