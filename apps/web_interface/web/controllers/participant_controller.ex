defmodule WebInterface.ParticipantController do
  use WebInterface.Web, :controller

  plug :scrub_params, "participants" when action in [:create, :update]

  def index(conn, _params) do
    participants = Participants.list
    boys = Participants.winners(true)
    girls = Participants.winners(false)
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

  def show(conn, %{"id" => id}) do
    case Participants.find(id) do
      nil ->
        conn
        |> put_flash(:err, "Deelnemer onbekend!")
        |> redirect(to: participant_path(conn, :index))
      participant ->
        games_played = Participants.games_played(participant)
        conn
        |> render("show.html", participant: participant, games_played: games_played)
    end
  end

  def edit(conn, %{"id" => id}) do
    case Participants.edit(id) do
      nil ->
        conn
        |> put_flash(:err, "Deelnemer onbekend!")
        |> redirect(to: participant_path(conn, :index))
      changeset ->
        conn
        |> render("edit.html", changeset: changeset, id: id)
    end
  end

  def update(conn, %{"id" => id, "participants" => params}) do
      case Participants.update(id, params) do
        {:error, changeset} ->
          conn
          |> render("edit.html", changeset: changeset)
        {:ok, _participant} ->
          conn
          |> put_flash(:info, "Deelnemer bijgewerkt")
          |> redirect(to: participant_path(conn, :index))
      end
  end
end
