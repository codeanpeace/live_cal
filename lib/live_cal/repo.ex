defmodule LiveCal.Repo do
  use Ecto.Repo,
    otp_app: :live_cal,
    adapter: Ecto.Adapters.Postgres
end
