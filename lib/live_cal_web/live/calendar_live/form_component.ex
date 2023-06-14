defmodule LiveCalWeb.CalendarLive.FormComponent do
  use LiveCalWeb, :live_component

  alias LiveCal.Scheduling

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage calendar records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="calendar-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Calendar</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{calendar: calendar} = assigns, socket) do
    changeset = Scheduling.change_calendar(calendar)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"calendar" => calendar_params}, socket) do
    changeset =
      socket.assigns.calendar
      |> Scheduling.change_calendar(calendar_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"calendar" => calendar_params}, socket) do
    save_calendar(socket, socket.assigns.action, calendar_params)
  end

  defp save_calendar(socket, :edit, calendar_params) do
    case Scheduling.update_calendar(socket.assigns.calendar, calendar_params) do
      {:ok, calendar} ->
        notify_parent({:saved, calendar})

        {:noreply,
         socket
         |> put_flash(:info, "Calendar updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_calendar(socket, :new, calendar_params) do
    case Scheduling.create_calendar(calendar_params) do
      {:ok, calendar} ->
        notify_parent({:saved, calendar})

        {:noreply,
         socket
         |> put_flash(:info, "Calendar created successfully")
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
