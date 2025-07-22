defmodule ContentApi.Api.Content do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, []}
  @foreign_key_type :string
  schema "content" do
    field :data, :string
    field :status, :string
    field :title, :string
    field :author, :string
    field :body, :string

    timestamps(type: :utc_datetime, inserted_at: :created_at)
  end

  @doc false
  def changeset(content, attrs) do
    content
    |> cast(attrs, [:title, :body, :author, :status, :data])
    |> validate_required([:title, :body, :author, :status])
    |> put_change(:data, attrs["data"] || nil)
  end

  @doc false
  def create_changeset(content, attrs) do
    content
    |> cast(attrs, [:title, :body, :author, :status, :data])
    |> validate_required([:title, :body, :author, :status])
    |> put_change(:data, attrs["data"] || nil)
    |> put_change(:id, Ulid.generate())
  end


end
