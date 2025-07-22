defmodule ContentApi.Repo do
  use Ecto.Repo,
    otp_app: :content_api,
    adapter: Ecto.Adapters.SQLite3
end
