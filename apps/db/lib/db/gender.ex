defmodule Db.Gender do
  @behaviour Ecto.Type
  def type, do: :boolean

  def cast(string) when is_binary(string) do
   case String.downcase(string) do
     "male" -> {:ok, true}
     "female" -> {:ok, false}
     _ -> :error
    end
  end

  def cast(atom) when is_atom(atom) do
    case atom do
      :male -> {:ok, true}
      :female -> {:ok, false}
      _ -> :error
    end
  end

  def cast(bool) when is_boolean(bool), do: bool
  def cast(_), do: :error

  def load(bool) when is_boolean(bool) do
    case bool do
      true -> {:ok, :male}
      false -> {:ok, :female}
      _ -> :error
    end
  end

  def dump(bool) when is_boolean(bool), do: {:ok, bool}
  def dump(_), do: :error
end
