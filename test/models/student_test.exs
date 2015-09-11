defmodule Studay.StudentTest do
  use Studay.ModelCase

  alias Studay.Student

  @valid_attrs %{email: "some content", firstname: "some content", lastname: "some content", telephone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Student.changeset(%Student{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Student.changeset(%Student{}, @invalid_attrs)
    refute changeset.valid?
  end
end
