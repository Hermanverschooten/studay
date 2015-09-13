defmodule Studay.Router do
  use Studay.Web, :router

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

  scope "/", Studay do
    pipe_through :browser # Use the default browser stack

    get "/", GameController, :index
    resources "/games", GameController do
      get "/scores", GameScoreController, :index, as: :score
      get "/scores/:student_id/new", GameScoreController, :new, as: :score
      get "/scores/:student_id", GameScoreController, :show, as: :score
      post "/scores/:student_id", GameScoreController, :create, as: :score
    end
    resources "/students", StudentController
    resources "/scores", ScoreController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Studay do
  #   pipe_through :api
  # end
end
