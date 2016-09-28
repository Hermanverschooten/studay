use Mix.Config

# Configure your database
config :db, Db.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "studay_2016_dev",
  hostname: "localhost",
  pool_size: 10
