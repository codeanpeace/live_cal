defmodule LiveCal.Scheduling.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :destination, :string
    field :name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :type, :destination])
    |> validate_required([:name, :type, :destination])
  end
end
