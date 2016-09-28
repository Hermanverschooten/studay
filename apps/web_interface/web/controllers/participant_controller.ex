defmodule WebInterface.ParticipantController do
  use WebInterface.Web, :controller

	plug :scrub_params, "participants" when action in [:create, :update]

  def index(conn, _params) do
		participants = Participants.list
    boys = Participants.winners(:male)
    girls = Participants.winners(:female)
    render conn, "index.html",
      participants: participants,
      boys: boys,
      girls: girls
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Participants.new
  end

  def create(conn, %{"participants" => params}) do
      case Participants.add(params) do
        {:ok, _participant} ->
          conn
          |> put_flash(:info, "Deelnemer toegevoegd!")
          |> redirect(to: participant_path(conn, :index))
        {:error, changeset} ->
          conn
          |> render("new.html", changeset: changeset)
      end
  end
end
