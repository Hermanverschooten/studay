defmodule Games.ScoringTest do
  use ExUnit.Case

  test "It takes a name and a maximum score" do
    {:ok, pid} = Games.Scoring.start(:bus, max: 8)
    {:status, found_pid, _, _ } = :sys.get_status(:bus)
    assert found_pid == pid
  end

  test "It calculates the 'score' percentage" do
    Games.Scoring.start(:bus, 8)
    Games.Scoring.start(:nachtlawaai, 250)

    assert 50 == Games.Scoring.calc_score(:bus, 4)
    assert 81.25 == Games.Scoring.calc_score(:bus, 6.5)
    assert 46 == Games.Scoring.calc_score(:nachtlawaai, 115)
  end
end
