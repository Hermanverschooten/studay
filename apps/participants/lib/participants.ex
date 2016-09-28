defmodule Participants do
  alias Db.Repo
  import Ecto.Query, only: [from: 2]


  def list do
    (
    from p in Db.Participants,
    order_by: [:lastname, :firstname]
    ) |> Repo.all
  end

  def add(params_list) do
    Db.Participants.add(params_list)
    |> Repo.insert
  end

  def add(firstname, lastname, gender, telephone, email) do
    add(%{
      firstname: firstname,
      lastname: lastname,
      gender: gender,
      telephone: telephone,
      email: email
    })
  end

  def new, do: Db.Participants.add(%{})

  def winners(gender, limit \\ 3) do
    (
    from p in Db.Participants,
    where: p.gender == ^gender,
    where: p.score > 0,
    where: p.games_to_play == 0,
    limit: ^limit
    ) |> Repo.all
  end

  def played_a_game(%Db.Participants{} = participant, score) do
    Db.Participants.add_game_played(participant, %{game_score: score})
    |> Repo.update!
  end

end
