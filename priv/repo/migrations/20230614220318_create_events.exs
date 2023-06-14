defmodule LiveCal.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :type, :string
      add :destination, :string
      add :calendar_id, references(:calendars, on_delete: :nothing)

      timestamps()
    end

    create index(:events, [:calendar_id])
  end
end
