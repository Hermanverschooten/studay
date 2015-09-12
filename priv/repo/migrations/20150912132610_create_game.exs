defmodule Studay.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false
      add :type, :integer, default: 1, null: false
      add :logo, :string
      add :active, :boolean, default: true, null: false
      add :max_time, :integer, default: -1, null: false
      add :bonus, :integer

      timestamps
    end

  end
end
