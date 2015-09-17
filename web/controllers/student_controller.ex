defmodule Studay.StudentController do
  use Studay.Web, :controller

  alias Studay.Student
  alias Studay.Game

  plug :scrub_params, "student" when action in [:create, :update]

  def index(conn, _params) do
    students = Student
                |> Student.with_position
                |> Repo.all
    boys = students
                |> Enum.filter(fn({student, pos}) -> !student.gender && pos end)
                |> Enum.take(3)
    girls = students
                |> Enum.filter(fn({student, pos}) -> student.gender && pos end)
                |> Enum.take(3)
    render(conn, "index.html", boys: boys, girls: girls)
  end

    def new(conn, _params) do
    changeset = Student.changeset(%Student{gender: false})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"student" => student_params}) do
    changeset = Student.changeset(%Student{}, student_params)

    case Repo.insert(changeset) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: student_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Repo.get!(Student, id)
    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    student = Repo.get!(Student, id)
    changeset = Student.changeset(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Repo.get!(Student, id)
    changeset = Student.changeset(student, student_params)

    case Repo.update(changeset) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "#{student.lastname} updated successfully.")
        |> redirect(to: student_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Repo.get!(Student, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: student_path(conn, :index))
  end
end
