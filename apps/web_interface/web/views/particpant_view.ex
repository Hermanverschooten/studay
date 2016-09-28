defmodule WebInterface.ParticipantView do
  use WebInterface.Web, :view

  def name(participant) do
    [participant.lastname, " ", participant.firstname]
  end
end
