defmodule ParticipantsTest do
  use Db.ModelCase

  test "Adding a participant" do

    assert [] == Participants.list

    Participants.add("Herman", "verschooten", :male, "+32475549993", "Herman@verschooten.net")

    assert 1 == Enum.count(Participants.list)
  end

  test "List winners by gender" do
    herman = Participants.add("Herman", "verschooten", :male, "+32475549993", "Herman@verschooten.net")
    Participants.add("Kristien", "Slegers", :female, "+32475549992", "Kristien@verschooten.net")

    assert 6 == herman.games_to_play

    herman
    |> Participants.played_a_game(100)
    |> Participants.played_a_game(101)
    |> Participants.played_a_game(102)
    |> Participants.played_a_game(103)
    |> Participants.played_a_game(104)
    |> Participants.played_a_game(105)

    [boy] = boys = Participants.winners(:male)

    assert 1 == Enum.count(boys)
    assert 0 == Enum.count(Participants.winners(:female))

    assert boy.firstname == "Herman"
    assert boy.score == 615

  end
end
