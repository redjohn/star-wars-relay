defmodule GraphqlLogger do
  require Logger

  @moduledoc """
  A plug that logs information related to graphql requests
  """
  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _) do
    vars = (conn |> Map.get(:body_params) |> Map.get("variables"))
    Logger.info("Variables: #{inspect(vars)}")
    conn
  end
end
