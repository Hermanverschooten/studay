defmodule WebInterface.ChannelCase do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.

  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      use Phoenix.ChannelTest


      # The default endpoint for testing
      @endpoint WebInterface.Endpoint
    end
  end

  setup tags do
    :ok
  end
end
