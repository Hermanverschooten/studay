defmodule WebInterface.PageController do
  use WebInterface.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", games: [
      %{name: "Bus", url: "bus"},
      %{name: "Stoepoverlast", url: "stoepoverlast"},
      %{name: "Vuilzak-voetbal", url: "vuilzak-voetbal"},
      %{name: "Nachtlawaai", url: "nachtlawaai"},
      %{name: "Wildplassen", url: "wildplassen"},
      %{name: "Bellekentrek", url: "bellekentrek"}
    ]
  end
end
