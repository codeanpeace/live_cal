defmodule LiveCalWeb.OrganizationUserSearchLive do
  use LiveCalWeb, :live_view

  def mount(_params, _session, socket) do
    organization_options = for org <- get_organizations(), do: {org.name, org.id}

    {:ok,
     socket
     |> assign(:form, to_form(%{"organization_id" => nil, "user_id" => nil}))
     |> assign(:organization_options, organization_options)
     |> assign(:user_options, [])}
  end

  def handle_event("select-organization", %{"organization_id" => org_id} = form_params, socket) do
    user_options = for user <- get_organization_users(org_id), do: {user.name, user.id}

    {:noreply,
      socket
      |> assign(:form, to_form(form_params))
      |> assign(:user_options, user_options)}
  end

  def handle_event("submit", %{"organization_id" => organization_id, "user_id" => user_id}, socket) do
    IO.puts("~~ form submitted for organzation id: #{organization_id} and user id: #{user_id}~~")
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <.form :let={f} for={@form} phx-submit="submit">
      <.input field={@form[:organization_id]} phx-change="select-organization"
        type="select"
        label="First select an organization to load its users:"
        placeholder="organization"
        options={@organization_options}
        prompt="-- select organization --"
      />
      <.input field={@form[:user_id]}
        type="select"
        label="Now select an organization user:"
        placeholder="user"
        options={@user_options}
        prompt="-- select user --"
        :if={f.params["organization_id"]}
      />
      <button>Submit</button>
    </.form>
    """
  end

  # stubbed users and organizations
  defp get_organizations(), do: [%{id: 1, name: "OrgA"}, %{id: 2, name: "OrgB"}]
  defp get_organization_users(organization_id) do
    case organization_id do
      "1" -> [%{id: 1, name: "John from OrgA"}, %{id: 2, name: "Jules from OrgA"}]
      "2" -> [%{id: 3, name: "Jack from OrgB"}, %{id: 4, name: "Jill from OrgB"}]
    end
  end
end
