defmodule Studay.StudentView do
  use Studay.Web, :view

  def name(student) do
    student.lastname <> " " <> student.firstname
  end

  def first_letter(student) do
    String.slice(student.lastname, 0..0) |> String.upcase
  end

  def gender(student) do
    if student.gender do
      "female"
    else
      "male"
    end
  end

  def games_completed(student) do
    "1/8"
  end
end
