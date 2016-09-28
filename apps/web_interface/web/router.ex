defmodule WebInterface.Router do
  use WebInterface.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WebInterface do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/participant", ParticipantController
    get "/score_board", ScoreBoardController, :index
    get "/games/:game", GameController, :index
    get "/games/:game/:id", GameController, :play
    post "/games/:game/:id", GameController, :create
    get "/score", ScoreboardController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebInterface do
  #   pipe_through :api
  # end
end
