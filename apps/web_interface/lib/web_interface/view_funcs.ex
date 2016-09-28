defmodule WebInterface.ViewFuncs do
  def name(participant) do
    [participant.lastname, " ", participant.firstname]
  end

  def gender(participant) do
    case participant.gender do
      true -> "male"
      false -> "female"
    end
  end
end
