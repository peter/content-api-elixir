defmodule ContentApi.ApiTest do
  use ContentApi.DataCase

  alias ContentApi.Api

  describe "content" do
    alias ContentApi.Api.Content

    import ContentApi.ApiFixtures

    @invalid_attrs %{data: nil, id: nil, status: nil, title: nil, author: nil, body: nil}

    test "list_content/0 returns all content" do
      content = content_fixture()
      assert Api.list_content() == [content]
    end

    test "get_content!/1 returns the content with given id" do
      content = content_fixture()
      assert Api.get_content!(content.id) == content
    end

    test "create_content/1 with valid data creates a content" do
      valid_attrs = %{data: "some data", id: "some id", status: "some status", title: "some title", author: "some author", body: "some body"}

      assert {:ok, %Content{} = content} = Api.create_content(valid_attrs)
      assert content.data == "some data"
      assert content.id == "some id"
      assert content.status == "some status"
      assert content.title == "some title"
      assert content.author == "some author"
      assert content.body == "some body"
    end

    test "create_content/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_content(@invalid_attrs)
    end

    test "update_content/2 with valid data updates the content" do
      content = content_fixture()
      update_attrs = %{data: "some updated data", id: "some updated id", status: "some updated status", title: "some updated title", author: "some updated author", body: "some updated body"}

      assert {:ok, %Content{} = content} = Api.update_content(content, update_attrs)
      assert content.data == "some updated data"
      assert content.id == "some updated id"
      assert content.status == "some updated status"
      assert content.title == "some updated title"
      assert content.author == "some updated author"
      assert content.body == "some updated body"
    end

    test "update_content/2 with invalid data returns error changeset" do
      content = content_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_content(content, @invalid_attrs)
      assert content == Api.get_content!(content.id)
    end

    test "delete_content/1 deletes the content" do
      content = content_fixture()
      assert {:ok, %Content{}} = Api.delete_content(content)
      assert_raise Ecto.NoResultsError, fn -> Api.get_content!(content.id) end
    end

    test "change_content/1 returns a content changeset" do
      content = content_fixture()
      assert %Ecto.Changeset{} = Api.change_content(content)
    end
  end
end
