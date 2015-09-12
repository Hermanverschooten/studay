defmodule Studay.GameTest do
  use Studay.ModelCase

  alias Studay.Game

  @valid_attrs %{active: true, logo: "some content", max_time: 42, name: "some content", type: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Game.changeset(%Game{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Game.changeset(%Game{}, @invalid_attrs)
    refute changeset.valid?
  end
end
