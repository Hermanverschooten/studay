defmodule WebInterface.ScoreboardController do
  use WebInterface.Web, :controller
  alias Db.Repo
  import Ecto.Query

  def index(conn, _params) do
    board = %{
      "bus" =>  get_leader("bus"),
      "stoepoverlast" => get_leader("stoepoverlast"),
      "vuilzak-voetbal" => get_leader("vuilzak-voetbal"),
      "nachtlawaai" => get_leader("nachtlawaai"),
      "wildplassen" => get_leader("wildplassen"),
      "bellekentrek" => get_leader("bellekentrek"),
    }

    all = get_ranking
    conn
    |> render("index.html", board: board, all: all)
  end

  defp get_leader(game) do
    (
    from p in Db.Participants,
    join: g in assoc(p, :games_played),
    where: g.game == ^game,
    order_by: [desc: g.score],
    limit: 3,
    select: [p.id, p.firstname, p.lastname, p.telephone, g.score]
    ) |>Repo.all
  end

  defp get_ranking do
    (
    from p in Db.Participants,
    order_by: [desc: p.score],
    select: [p.id,p.firstname, p.lastname, p.telephone, p.score, p.games_to_play]
    ) |>Repo.all
  end
end
