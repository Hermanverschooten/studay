defmodule WebInterface.GameController do
  use WebInterface.Web, :controller

  def index(conn, %{"game" => game}) do
    participants = Participants.list_not_played_game(game)
    conn
    |> render("index.html", game: game, participants: participants)
  end

  def play(conn, %{"game" => game, "id" => id}) do
    participant = Participants.find(id)
    conn
    |> render("play.html",game: game, participant: participant)
  end

  def create(conn, %{"game" => game, "id" => id, "score" => %{"points" => points}}) do
    participant = Participants.find(id)

    Participants.played_a_game(participant, game, points)
    conn
    |> render("show.html", game: game, participant: participant, score: points)
  end
end
