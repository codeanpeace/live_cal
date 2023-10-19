defmodule LiveCalWeb.Router do
  use LiveCalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveCalWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveCalWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/calendars", CalendarLive.Index, :index
    live "/calendars/new", CalendarLive.Index, :new
    live "/calendars/:id/edit", CalendarLive.Index, :edit

    live "/calendars/:id", CalendarLive.Show, :show
    live "/calendars/:id/show/edit", CalendarLive.Show, :edit

    live "/events", EventLive.Index, :index
    live "/events/new", EventLive.Index, :new
    live "/events/:id/edit", EventLive.Index, :edit

    live "/organization_user_search", OrganizationUserSearchLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveCalWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:live_cal, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveCalWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
