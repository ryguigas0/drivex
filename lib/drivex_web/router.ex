defmodule DrivexWeb.Router do
  use DrivexWeb, :router

  alias DrivexWeb.Plugs.VerifyToken

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(VerifyToken)
  end

  scope "/api", DrivexWeb do
    pipe_through(:api)

    get("/health", HealthController, :index)

    resources "/user", UserController, only: [:create, :show]
    post "/token", TokenController, :create

    scope "/protected" do
      pipe_through([:auth])
      resources "/upload", UploadController, only: [:create, :delete, :index, :show]
      get "/upload/download/:id", UploadController, :download
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: DrivexWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
