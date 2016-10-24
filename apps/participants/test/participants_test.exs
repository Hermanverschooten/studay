defmodule ParticipantsTest do
  use Db.ModelCase

  test "Adding a participant" do

    assert [] == Participants.list

    Participants.add("Herman", "verschooten", true, "+32475549993", "Herman@verschooten.net")

    assert 1 == Enum.count(Participants.list)
  end

  test "Add a game played" do
    {:ok, herman} = Participants.add("Herman", "verschooten", true, "+32475549993", "Herman@verschooten.net")
    herman
    |> Participants.played_a_game("bus",100 ,nil)

    games_played = Participants.games_played(herman)

    assert Enum.count(games_played) == 1

    [first_game] = games_played

    assert first_game.game == "bus"


  end

  test "Who has not played this game?" do
    {:ok, herman} = Participants.add("Herman", "verschooten", true, "+32475549993", "Herman@verschooten.net")
    {:ok, x10 } = Participants.add("Kristien", "Slegers", false, "+32475549992", "Kristien@verschooten.net")
    herman
    |> Participants.played_a_game("bus",100 ,nil)

    not_played = Participants.list_not_played_game("bus")

    assert Enum.count(not_played) == 1
    [non_player] = not_played

    assert non_player.firstname == x10.firstname

  end

  test "List winners by gender" do
    {:ok, herman} = Participants.add("Herman", "verschooten", true, "+32475549993", "Herman@verschooten.net")
    Participants.add("Kristien", "Slegers", false, "+32475549992", "Kristien@verschooten.net")

    assert 5 == herman.games_to_play

    herman
    |> Participants.played_a_game("bus",100 ,nil)
    |> Participants.played_a_game("stoepoverlast",101 ,nil)
    |> Participants.played_a_game("vuizak-voetbal",102 ,nil)
    |> Participants.played_a_game("nachtlawaai",103 ,nil)
    |> Participants.played_a_game("wildplassen",104 ,nil)
    |> Participants.played_a_game("bellekentrek",105 ,nil)

    [boy] = boys = Participants.winners(true)

    assert 1 == Enum.count(boys)
    assert 0 == Enum.count(Participants.winners(false))

    assert boy.firstname == "Herman"
    assert boy.score == 615

  end

  test "Update an existing participant" do
    {:ok, herman} = Participants.add("Herman", "verschooten", false, "+32475549993", "Herman@verschooten.net")
    {:ok, _participant} = Participants.update(herman.id, %{ gender: true })

    participant = Participants.find(herman.id)
    assert participant.gender == true

  end
end
