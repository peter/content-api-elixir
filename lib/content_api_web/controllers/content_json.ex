defmodule ContentApiWeb.ContentJSON do
  alias ContentApi.Api.Content

  @doc """
  Renders a list of content.
  """
  def index(%{content: content}) do
    for(content <- content, do: data(content))
  end

  @doc """
  Renders a single content.
  """
  def show(%{content: content}) do
    data(content)
  end

  defp data(%Content{} = content) do
    %{
      id: content.id,
      title: content.title,
      body: content.body,
      author: content.author,
      status: content.status,
      # data: content.data
    }
  end
end
