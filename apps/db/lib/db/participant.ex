defmodule Db.Participant do
  alias Db.{Repo, Participants}

  def list do
    Participants |> Repo.all
  end

  def add(firstname, lastname, gender, telephone, email) do
    Participants.add(%{
      firstname: firstname,
      lastname: lastname,
      gender: gender,
      telephone: telephone,
      email: email
    }) |> Repo.insert!
  end

end
