defmodule ContentApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ContentApiWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: ContentApiWeb.ErrorHTML, json: ContentApiWeb.ErrorJSON)
    |> render(:"404")
  end

  # Handle changeset errors
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(html: ContentApiWeb.ErrorHTML, json: ContentApiWeb.ErrorJSON)
    |> render(:"422", changeset: changeset)
  end
end
