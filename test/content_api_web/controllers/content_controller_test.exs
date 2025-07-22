defmodule ContentApiWeb.ContentControllerTest do
  use ContentApiWeb.ConnCase

  import ContentApi.ApiFixtures

  alias ContentApi.Api.Content

  @create_attrs %{
    data: "some data",
    status: "some status",
    title: "some title",
    author: "some author",
    body: "some body"
  }
  @update_attrs %{
    data: "some updated data",
    status: "some updated status",
    title: "some updated title",
    author: "some updated author",
    body: "some updated body"
  }
  @invalid_attrs %{data: nil, status: nil, title: nil, author: nil, body: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all content", %{conn: conn} do
      conn = get(conn, ~p"/api/content")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create content" do
    test "renders content when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/content", content: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/content/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some author",
               "body" => "some body",
               "data" => "some data",
               "status" => "some status",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/content", content: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update content" do
    setup [:create_content]

    test "renders content when data is valid", %{conn: conn, content: %Content{id: id} = content} do
      conn = put(conn, ~p"/api/content/#{content}", content: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/content/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some updated author",
               "body" => "some updated body",
               "data" => "some updated data",
               "status" => "some updated status",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, content: content} do
      conn = put(conn, ~p"/api/content/#{content}", content: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete content" do
    setup [:create_content]

    test "deletes chosen content", %{conn: conn, content: content} do
      conn = delete(conn, ~p"/api/content/#{content}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/content/#{content}")
      end
    end
  end

  defp create_content(_) do
    content = content_fixture()
    %{content: content}
  end
end
