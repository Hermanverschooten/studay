defmodule Db.ParticipantTest do
  use Db.ModelCase

  alias Db.Participant

  test "Adding a participant" do

    assert [] == Participant.list

    Participant.add("Herman", "verschooten", :male, "+32475549993", "Herman@verschooten.net")

    assert 1 == Enum.count(Participant.list)
  end
end
