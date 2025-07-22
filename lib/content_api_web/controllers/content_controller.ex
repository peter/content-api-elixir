defmodule ContentApiWeb.ContentController do
  use ContentApiWeb, :controller

  alias ContentApi.Api
  alias ContentApi.Api.Content

  action_fallback ContentApiWeb.FallbackController

  plug :accepts, ["json"]

  def index(conn, _params) do
    content = Api.list_content()
    render(conn, :index, content: content)
  end

  def create(conn, content_params) do
    with {:ok, %Content{} = content} <- Api.create_content(content_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/content/#{content.id}")
      |> render(:show, content: content)
    end
  end

  def show(conn, %{"id" => id}) do
    content = Api.get_content!(id)
    render(conn, :show, content: content)
  end

  def update(conn, body) do
    content = Api.get_content!(body["id"])
    content_params = body |> Map.take(["id", "title", "body", "author", "status", "data"])
    with {:ok, %Content{} = content} <- Api.update_content(content, content_params) do
      render(conn, :show, content: content)
    end
  end

  def delete(conn, %{"id" => id}) do
    content = Api.get_content!(id)

    with {:ok, %Content{}} <- Api.delete_content(content) do
      send_resp(conn, :no_content, "")
    end
  end
end
