defmodule LiveCal.Scheduling.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :destination, :string
    field :name, :string
    field :type, :string
    field :show_as, Ecto.Enum, values: [:free, :busy, :tbd], default: :busy

    belongs_to :calendar, LiveCal.Scheduling.Calendar

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :type, :destination, :show_as, :calendar_id])
    |> cast_assoc(:calendar)
    |> validate_required([:name, :type, :destination, :show_as])
  end
end
