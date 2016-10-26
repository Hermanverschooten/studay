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

  def find(id) when is_binary(id), do: find(String.to_integer(id))
  def find(id) when is_integer(id), do: Repo.get(Db.Participants, id)

  def edit(id) when is_binary(id), do: edit(String.to_integer(id))
  def edit(id) when is_integer(id) do
    case Repo.get(Db.Participants, id) do
      nil -> nil
      participant ->
        Db.Participants.update(participant)
    end
  end

  def update(id, params) when is_binary(id), do: update(String.to_integer(id), params)
  def update(id, params) when is_integer(id) do
    case find(id) do
      nil -> {:error, params}
      participant ->
        Db.Participants.update(participant, params) |> Repo.update
    end
  end

  def winners(gender, limit \\ 3) do
    (
    from p in Db.Participants,
    where: p.gender == ^gender,
    where: p.score > 0,
    where: p.games_to_play == 0,
    limit: ^limit
    ) |> Repo.all
  end

  def played_a_game(participant, game, score, data \\ nil)
  def played_a_game(%Db.Participants{} = participant, game, score, data) when is_binary(score) do
    played_a_game(participant, game, String.to_integer(score), data)
  end

  def played_a_game(%Db.Participants{} = participant, game, score, data) do
    Repo.transaction(fn ->
      game_score = Games.Scoring.calc_score(game, score, data)
      Db.GamesPlayed.add(%{participants_id: participant.id, game: game, score: score, data: data})
      |> Repo.insert!
      Db.Participants.add_game_played(participant, %{game_score: game_score})
      |> Repo.update!
    end
    )
  end

  def games_played(%Db.Participants{} = participant) do
    (
    from g in Db.GamesPlayed,
    where: g.participants_id == ^participant.id
    ) |> Repo.all
  end

  def list_not_played_game(game) do
    (
    from p in Db.Participants,
    where: not p.id in fragment("select participants_id from games_played where game = ?", ^game)
    ) |> Repo.all
  end

end
