defmodule Studay.PageController do
  use Studay.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
