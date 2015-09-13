defmodule Studay.GameScoreController do
  use Studay.Web, :controller

  alias Studay.Score
  alias Studay.Game
  alias Studay.Student

  plug :scrub_params, "score" when action in [:create]

  def index(conn, %{"game_id" => game_id}) do
    game = Repo.get(Game, game_id)
    students = Repo.all(query(game))
    render(conn, "index.html", students: students, game: game)
  end

  def new(conn, %{"game_id" => game_id, "student_id" => student_id}) do
    game = Repo.get(Game, game_id)
    student = Repo.get(Student, student_id)
    changeset = Score.changeset(%Score{ game_id: game_id, student_id: student_id})
    render(conn, "new.html", changeset: changeset, student: student, game: game)
  end

  defp query(game) do
    from s in Student,
      where: fragment("id not in (select student_id from scores where game_id = ?)", ^game.id),
      order_by: :lastname
  end

  def create(conn, %{"game_id" => game_id, "student_id" => student_id, "score" => score_params}) do
    changeset = Score.changeset(%Score{game_id: String.to_integer(game_id), student_id: String.to_integer(student_id)}, score_params)
    game = Repo.get(Game, game_id)
    student = Repo.get(Student, student_id)

    case Repo.insert(changeset) do
      {:ok, _score} ->
        conn
        |> put_flash(:info, "Score created successfully.")
        |> redirect(to: game_game_score_path(conn, :show, game, student))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, student: student, game: game)
    end
  end

  def show(conn, %{"game_id" => game_id, "student_id" => student_id}) do
    score = Repo.get_by(Score, game_id: game_id, student_id: student_id)
    game = Repo.get(Game, game_id)
    student = Repo.get(Student, student_id)
    render(conn, "show.html", score: score, game: game, student: student)
  end

end
