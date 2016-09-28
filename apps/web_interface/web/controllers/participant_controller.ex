defmodule WebInterface.ParticipantController do
  use WebInterface.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", participants: []
  end

  def new(conn, _params) do
    render conn, "new.html", participants: []
  end
end
