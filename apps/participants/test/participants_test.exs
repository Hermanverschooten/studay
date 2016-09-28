defmodule ParticipantsTest do
  use ExUnit.Case
  doctest Participants

  test "Add a participant" do
    Participants.start_link
    participant = Participants.add("Herman", "verschooten", :male, "herman@verschooten.net")
    assert participant.firstname == "Herman"
  end

  test "Get the list of participants" do
    Participants.start_link
    Participants.add("Herman", "verschooten", :male, "herman@verschooten.net")
    Participants.add("Hans", "verschooten", :male, "hans@verschooten.com")

    list = Participants.list

    assert Enum.count(list) == 2
  end

  test "Get the list of participants sort" do
    Participants.start_link
    p1 = Participants.add("Herman", "verschooten", :male, "herman@verschooten.net")
    p2 = Participants.add("Hans", "verschooten", :male, "hans@verschooten.com")

    list = Participants.sorted_list(fn(p) -> [p.lastname, p.firstname] end)

    assert [p2, p1] == list
  end

  test "Get a single participant by id" do
    Participants.start_link
    p1 = Participants.add("Herman", "verschooten", :male, "herman@verschooten.net")
    assert p1 == Participants.get(p1.id)
  end

  test "Add a played game" do
    Participants.start_link
    p1 = Participants.add("Herman", "verschooten", :male, "herman@verschooten.net")

    Participants.add_game(p1.id, %Games.PlayedGame{game: :bus, score: 100})
    Participants.add_game(p1.id, %Games.PlayedGame{game: :stoepoverlast, score: 10})

    part = Participants.get(p1.id)

    assert part.score == 110

  end
end
