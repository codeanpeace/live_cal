defmodule LiveCalWeb.CalendarLiveTest do
  use LiveCalWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveCal.SchedulingFixtures

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp create_calendar(_) do
    calendar = calendar_fixture()
    %{calendar: calendar}
  end

  describe "Index" do
    setup [:create_calendar]

    test "lists all calendars", %{conn: conn, calendar: calendar} do
      {:ok, _index_live, html} = live(conn, ~p"/calendars")

      assert html =~ "Listing Calendars"
      assert html =~ calendar.description
    end

    test "saves new calendar", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/calendars")

      assert index_live |> element("a", "New Calendar") |> render_click() =~
               "New Calendar"

      assert_patch(index_live, ~p"/calendars/new")

      assert index_live
             |> form("#calendar-form", calendar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#calendar-form", calendar: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/calendars")

      html = render(index_live)
      assert html =~ "Calendar created successfully"
      assert html =~ "some description"
    end

    test "updates calendar in listing", %{conn: conn, calendar: calendar} do
      {:ok, index_live, _html} = live(conn, ~p"/calendars")

      assert index_live |> element("#calendars-#{calendar.id} a", "Edit") |> render_click() =~
               "Edit Calendar"

      assert_patch(index_live, ~p"/calendars/#{calendar}/edit")

      assert index_live
             |> form("#calendar-form", calendar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#calendar-form", calendar: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/calendars")

      html = render(index_live)
      assert html =~ "Calendar updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes calendar in listing", %{conn: conn, calendar: calendar} do
      {:ok, index_live, _html} = live(conn, ~p"/calendars")

      assert index_live |> element("#calendars-#{calendar.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#calendars-#{calendar.id}")
    end
  end

  describe "Show" do
    setup [:create_calendar]

    test "displays calendar", %{conn: conn, calendar: calendar} do
      {:ok, _show_live, html} = live(conn, ~p"/calendars/#{calendar}")

      assert html =~ "Show Calendar"
      assert html =~ calendar.description
    end

    test "updates calendar within modal", %{conn: conn, calendar: calendar} do
      {:ok, show_live, _html} = live(conn, ~p"/calendars/#{calendar}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Calendar"

      assert_patch(show_live, ~p"/calendars/#{calendar}/show/edit")

      assert show_live
             |> form("#calendar-form", calendar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#calendar-form", calendar: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/calendars/#{calendar}")

      html = render(show_live)
      assert html =~ "Calendar updated successfully"
      assert html =~ "some updated description"
    end
  end
end
