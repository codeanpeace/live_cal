defmodule LiveCal.SchedulingTest do
  use LiveCal.DataCase

  alias LiveCal.Scheduling

  describe "calendars" do
    alias LiveCal.Scheduling.Calendar

    import LiveCal.SchedulingFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_calendars/0 returns all calendars" do
      calendar = calendar_fixture()
      assert Scheduling.list_calendars() == [calendar]
    end

    test "get_calendar!/1 returns the calendar with given id" do
      calendar = calendar_fixture()
      assert Scheduling.get_calendar!(calendar.id) == calendar
    end

    test "create_calendar/1 with valid data creates a calendar" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Calendar{} = calendar} = Scheduling.create_calendar(valid_attrs)
      assert calendar.description == "some description"
      assert calendar.name == "some name"
    end

    test "create_calendar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduling.create_calendar(@invalid_attrs)
    end

    test "update_calendar/2 with valid data updates the calendar" do
      calendar = calendar_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Calendar{} = calendar} = Scheduling.update_calendar(calendar, update_attrs)
      assert calendar.description == "some updated description"
      assert calendar.name == "some updated name"
    end

    test "update_calendar/2 with invalid data returns error changeset" do
      calendar = calendar_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduling.update_calendar(calendar, @invalid_attrs)
      assert calendar == Scheduling.get_calendar!(calendar.id)
    end

    test "delete_calendar/1 deletes the calendar" do
      calendar = calendar_fixture()
      assert {:ok, %Calendar{}} = Scheduling.delete_calendar(calendar)
      assert_raise Ecto.NoResultsError, fn -> Scheduling.get_calendar!(calendar.id) end
    end

    test "change_calendar/1 returns a calendar changeset" do
      calendar = calendar_fixture()
      assert %Ecto.Changeset{} = Scheduling.change_calendar(calendar)
    end
  end

  describe "events" do
    alias LiveCal.Scheduling.Event

    import LiveCal.SchedulingFixtures

    @invalid_attrs %{destination: nil, name: nil, type: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Scheduling.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Scheduling.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{destination: "some destination", name: "some name", type: "some type"}

      assert {:ok, %Event{} = event} = Scheduling.create_event(valid_attrs)
      assert event.destination == "some destination"
      assert event.name == "some name"
      assert event.type == "some type"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scheduling.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{destination: "some updated destination", name: "some updated name", type: "some updated type"}

      assert {:ok, %Event{} = event} = Scheduling.update_event(event, update_attrs)
      assert event.destination == "some updated destination"
      assert event.name == "some updated name"
      assert event.type == "some updated type"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Scheduling.update_event(event, @invalid_attrs)
      assert event == Scheduling.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Scheduling.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Scheduling.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Scheduling.change_event(event)
    end
  end
end
