defmodule WebInterface.ScoreBoardController do
  use WebInterface.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", scores: []
  end
end
