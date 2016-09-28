defmodule WebInterface.PageController do
  use WebInterface.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", games: [
      %{name: "Bus", url: "#"},
      %{name: "Stoepoverlast", url: "#"},
      %{name: "Vuilzak-voetbal", url: "#"},
      %{name: "Nachtlawaai", url: "#"},
      %{name: "Wildplassen", url: "#"},
      %{name: "Bellekentrek", url: "#"}
    ]
  end
end
