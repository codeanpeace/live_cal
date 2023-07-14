defmodule LiveCalWeb.CalendarLive.Index do
  use LiveCalWeb, :live_view

  alias LiveCal.Scheduling
  alias LiveCal.Scheduling.Calendar

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :calendars, Scheduling.list_calendars())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Calendar")
    |> assign(:calendar, Scheduling.get_calendar!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Calendar")
    |> assign(:calendar, %Calendar{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Calendars")
    |> assign(:calendar, nil)
  end

  @impl true
  def handle_info({LiveCalWeb.CalendarLive.FormComponent, {:saved, calendar}}, socket) do
    {:noreply, stream_insert(socket, :calendars, calendar)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    calendar = Scheduling.get_calendar!(id)
    {:ok, _} = Scheduling.delete_calendar(calendar)

    {:noreply, stream_delete(socket, :calendars, calendar)}
  end

  def accessible_js_toggle_1(js \\ %JS{}, [to: selector]) do
    js
    |> JS.remove_attribute("aria-hidden", to: selector <> "[style*='display: none']")
    |> JS.set_attribute({"aria-hidden", "true"}, to: selector <> ":not([style*='display: none'])")
    |> JS.remove_class("invisible", to: selector <> "[style*='display: none']")
    |> JS.add_class("invisible", to: selector <> ":not([style*='display: none'])")
    |> JS.toggle(to: selector)
  end

  def accessible_js_toggle_2(js \\ %JS{}, [to: selector]) do
    js
    |> JS.remove_attribute("aria-hidden", to: selector <> ".invisible")
    |> JS.set_attribute({"aria-hidden", "true"}, to: selector <> ":not(.invisible)")
    |> JS.remove_class("invisible", to: selector <> ".invisible")
    |> JS.add_class("invisible", to: selector <> ":not(.invisible)")
    |> JS.toggle(to: selector)
  end

  # note: toggling while selecting by attribute does not work
  #def accessible_js_toggle_3(js \\ %JS{}, [to: selector]) do
    #js
    #|> JS.remove_attribute("aria-hidden", to: selector <> "[aria-hidden='true']")
    #|> JS.set_attribute({"aria-hidden", "true"}, to: selector <> ":not([aria-hidden='true'])")
    #|> JS.toggle(to: selector)
  #end
end
