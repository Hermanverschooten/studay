defmodule Studay.Repo.Migrations.AddGenderToStudent do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :gender, :boolean, default: false
    end
  end
end
