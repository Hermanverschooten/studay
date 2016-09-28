defmodule Games do
  use Application
  alias Games.Scoring

  def start(_type, _args) do
    import Supervisor.Spec

    games = [
        %Scoring{name: "bus",                 type: :score, max: 6},
        %Scoring{name: "stoepoverlast",       type: :speed, max: 900000},
        %Scoring{name: "nachtlawaai",         type: :score, max: 200},
        %Scoring{name: "vuilzak-voetbal",  type: :speed, max: 900000},
        %Scoring{name: "wildplassen",         type: :score, max: 1000},
        %Scoring{name: "bellekentrek",        type: :speed, max: 900000},
      ]

    children = [
      supervisor(Games.Scoring, [games])
    ]

    opts = [strategy: :one_for_one, name: Games.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
