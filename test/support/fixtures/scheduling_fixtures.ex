defmodule LiveCal.SchedulingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCal.Scheduling` context.
  """

  @doc """
  Generate a calendar.
  """
  def calendar_fixture(attrs \\ %{}) do
    {:ok, calendar} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> LiveCal.Scheduling.create_calendar()

    calendar
  end

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        destination: "some destination",
        name: "some name",
        type: "some type"
      })
      |> LiveCal.Scheduling.create_event()

    event
  end
end
