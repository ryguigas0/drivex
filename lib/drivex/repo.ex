defmodule Drivex.Repo do
  use Ecto.Repo,
    otp_app: :drivex,
    adapter: Ecto.Adapters.Postgres
end
