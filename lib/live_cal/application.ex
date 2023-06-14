defmodule LiveCal.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveCalWeb.Telemetry,
      # Start the Ecto repository
      LiveCal.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveCal.PubSub},
      # Start Finch
      {Finch, name: LiveCal.Finch},
      # Start the Endpoint (http/https)
      LiveCalWeb.Endpoint
      # Start a worker by calling: LiveCal.Worker.start_link(arg)
      # {LiveCal.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveCal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveCalWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
