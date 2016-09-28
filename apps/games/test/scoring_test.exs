defmodule Games.ScoringTest do
  use ExUnit.Case
  alias Games.Scoring

  test "It calculates the 'score' percentage" do
    assert 667 == Games.Scoring.calc_score("bus", 4)
    assert 1083 == Games.Scoring.calc_score("bus", 6.5)
    assert 575 == Games.Scoring.calc_score("nachtlawaai", 115)
  end
end
