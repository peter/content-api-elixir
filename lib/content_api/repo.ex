

defmodule ContentApi.Repo do
  if System.get_env("DATABASE_ENGINE") == "postgres" do
    IO.puts "Using Ecto.Adapters.Postgres"
    use Ecto.Repo,
      otp_app: :content_api,
      adapter: Ecto.Adapters.Postgres
  else
    IO.puts "Using Ecto.Adapters.SQLite3"
    use Ecto.Repo,
      otp_app: :content_api,
      adapter: Ecto.Adapters.SQLite3
  end
end
