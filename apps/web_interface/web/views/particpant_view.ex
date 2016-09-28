defmodule WebInterface.ParticipantView do
  use WebInterface.Web, :view
  import WebInterface.ViewFuncs

  def display_score(score, "stoepoverlast"), do: display_score(score, :speed)
  def display_score(score, "vuilzak-voetbal"), do: display_score(score, :speed)
  def display_score(score, :perc) do
    Float.round(score / 1000,3)
  end

  def display_score(score, :speed) do
    msec = rem score, 1000
    pts = div score, 1000
    sec = rem pts, 60
    pts = div pts, 60
    min = rem pts, 60
    hrs = div pts, 60
    [ print_nr(hrs,2), ":", print_nr(min,2), ":", print_nr(sec,2), ".", print_nr(msec,2) ]
  end

  def display_score(score, _game), do: score

  defp print_nr(score, digits) do
    String.slice("000" <> IO.chardata_to_string(Integer.to_char_list(score)),-1*digits..-1)
  end

end
