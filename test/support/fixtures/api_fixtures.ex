defmodule ContentApi.ApiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ContentApi.Api` context.
  """

  @doc """
  Generate a content.
  """
  def content_fixture(attrs \\ %{}) do
    {:ok, content} =
      attrs
      |> Enum.into(%{
        author: "some author",
        body: "some body",
        data: "some data",
        id: "some id",
        status: "some status",
        title: "some title"
      })
      |> ContentApi.Api.create_content()

    content
  end
end
