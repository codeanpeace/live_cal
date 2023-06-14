defmodule LiveCal.Repo.Migrations.CreateCalendars do
  use Ecto.Migration

  def change do
    create table(:calendars) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
