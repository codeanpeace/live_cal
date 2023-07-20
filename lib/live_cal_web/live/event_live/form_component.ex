defmodule LiveCalWeb.EventLive.FormComponent do
  use LiveCalWeb, :live_component

  alias LiveCal.Scheduling

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage event records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="event-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:type]} type="text" label="Type" />
        <.input field={@form[:destination]} type="text" label="Destination" />

        <%= if @add_to_existing_calendar do %>
          <.input field={@form[:calendar_id]}
            type="select"
            label="Add to existing calendar:"
            placeholder="calendar"
            options={@calendar_options}
            prompt="-- select a calendar for this event --"
          />
        <% else %>
          <.simple_form for={@calendar_form} id="calendar-form">
            <.input field={@calendar_form[:name]}
              type="text"
              label="Add to new calendar:"
              placeholder="name"
            />
          </.simple_form>
        <% end %>

        <p>-- or --</p>

        <.button type="button" phx-click="toggle_calendar_source" phx-target={@myself}>
          <span :if={@add_to_existing_calendar}>Add to new calendar instead</span>
          <span :if={!@add_to_existing_calendar}>Choose existing calendar instead</span>
        </.button>

        <:actions>
          <.button phx-disable-with="Saving...">Save Event</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{event: event} = assigns, socket) do
    event_changeset = Scheduling.change_event(event)
    new_calendar_changeset = Scheduling.change_calendar(%Scheduling.Calendar{})
    calendar_options = for cal <- Scheduling.list_calendars, do: {cal.name, cal.id}

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(event_changeset)
     |> assign(:add_to_existing_calendar, true)
     |> assign(:calendar_options, calendar_options)
     |> assign(:calendar_form, to_form(new_calendar_changeset))}
  end

  def handle_event("toggle_calendar_source", _, socket) do
    {:noreply, assign(socket, :add_to_existing_calendar, !socket.assigns.add_to_existing_calendar)}
  end

  @impl true
  def handle_event("validate", %{"event" => event_params, "calendar" => calendar_params}, socket) do
    event_changeset =
      socket.assigns.event
      |> Scheduling.change_event(event_params)
      |> Map.put(:action, :validate)

    calendar_changeset =
      %Scheduling.Calendar{}
      |> Scheduling.change_calendar(calendar_params)
      |> Map.put(:action, :validate)

    {:noreply,
      socket
      |> assign_form(event_changeset)
      |> assign(:calendar_form, to_form(calendar_changeset))}
  end

  def handle_event("validate", %{"event" => event_params}, socket) do
    changeset =
      socket.assigns.event
      |> Scheduling.change_event(event_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"calendar" => calendar_params, "event" => event_params}, socket) do
    calendar_params_with_event = Map.put(calendar_params, "events", [event_params])
    case Scheduling.create_calendar(calendar_params_with_event) do
      {:ok, calendar} ->
        notify_parent({:saved, hd(calendar.events)})

        {:noreply,
         socket
         |> put_flash(:info, "Event created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
    # or in two seperate inserts
    #with {:ok, calendar} <- Scheduling.create_calendar(calendar_params),
         #do: save_event(socket, :new, Map.put(event_params,"calendar_id", calendar.id))
  end

  def handle_event("save", %{"event" => event_params}, socket) do
    save_event(socket, socket.assigns.action, event_params)
  end

  defp save_event(socket, :edit, event_params) do
    case Scheduling.update_event(socket.assigns.event, event_params) do
      {:ok, event} ->
        notify_parent({:saved, event})

        {:noreply,
         socket
         |> put_flash(:info, "Event updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_event(socket, :new, event_params) do
    case Scheduling.create_event(event_params) do
      {:ok, event} ->
        notify_parent({:saved, event})

        {:noreply,
         socket
         |> put_flash(:info, "Event created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
