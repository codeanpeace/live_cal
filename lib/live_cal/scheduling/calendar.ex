defmodule LiveCal.Scheduling.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calendars" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
