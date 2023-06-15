defmodule LiveCal.Scheduling.Calendar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calendars" do
    field :description, :string
    field :name, :string

    has_many :events, LiveCal.Scheduling.Event, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(calendar, attrs) do
    calendar
    |> cast(attrs, [:name, :description])
    |> cast_assoc(:events,
      with: &LiveCal.Scheduling.Event.changeset/2,
      sort_param: :events_sort,
      drop_param: :events_drop
    )
    |> validate_required([:name, :description])
  end
end
