defmodule WebInterface.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      import WebInterface.Router.Helpers

      # The default endpoint for testing
      @endpoint WebInterface.Endpoint
    end
  end

  setup tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
