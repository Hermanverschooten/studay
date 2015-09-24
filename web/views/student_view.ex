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

  def print_nr(point,digits) do
    String.slice("000" <> IO.chardata_to_string(Integer.to_char_list(point)),-1*digits..-1)
  end
  def format_time(points) do
    msec = rem points, 1000
    pts = div points, 1000
    sec = rem pts, 60
    pts = div pts, 60
    min = rem pts, 60
    hrs = div pts, 60
    print_nr(hrs,2) <> ":" <> print_nr(min,2) <> ":" <> print_nr(sec,2) <> "." <> print_nr(msec,2)
  end
  def display_score(score) do
    format_score(score.points, score.game)
  end

  def format_score(points, %{ type: 1 }) do
    format_time(points)
  end

  def format_score(points, %{ type: 2 }) do
    format_time(points)
    1
  end

  def format_score(points, %{ type: 3 }) do
    points
  end

  def format_score(points, %{ type: 4 }) do
    format_time(points)
  end


end
