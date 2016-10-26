defmodule WebInterface.ScoreboardController do
  use WebInterface.Web, :controller
  alias Db.Repo
  import Ecto.Query

  def index(conn, _params) do
    all = get_ranking
    conn
    |> render("index.html", all: all)
  end

  defp get_ranking do
    (
    from p in Db.Participants,
    order_by: [desc: p.score],
    select: [p.id,p.firstname, p.lastname, p.telephone, p.score, p.games_to_play]
    ) |>Repo.all
  end
end
