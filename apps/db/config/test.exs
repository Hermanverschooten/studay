use Mix.Config

# Print only warnings and errors during test
config :logger, level: :debug

# Configure your database
config :db, Db.Repo,
  adapter: Ecto.Adapters.Postgres,
  # username: "postgres",
  # password: "postgres",
  database: "studay_2016_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  loggers: [{Ecto.LogEntry, :log, [:debug]}],
  log_level: :debug
