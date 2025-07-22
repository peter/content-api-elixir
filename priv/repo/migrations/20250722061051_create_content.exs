defmodule ContentApi.Repo.Migrations.CreateContent do
  use Ecto.Migration

  def change do
    if System.get_env("DATABASE_ENGINE") == "postgres" do
      execute """
      CREATE TABLE IF NOT EXISTS content (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        author TEXT NOT NULL,
        status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived')),
        data JSONB DEFAULT NULL,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
      );
      """
      execute "CREATE INDEX idx_content_status ON content(status);"
      execute "CREATE INDEX idx_content_author ON content(author);"
      execute "CREATE INDEX idx_content_created_at ON content(created_at);"
      execute "CREATE INDEX idx_content_data ON content USING GIN (data);"
    else
      execute """
      CREATE TABLE IF NOT EXISTS content (
        id TEXT PRIMARY KEY, -- ULID as primary key
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        author TEXT NOT NULL,
        status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'archived')),
        data JSON DEFAULT '{}', -- JSON data column
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );

      CREATE INDEX idx_content_status ON content(status);
      CREATE INDEX idx_content_author ON content(author);
      CREATE INDEX idx_content_created_at ON content(created_at);
      """
    end
  end
end
