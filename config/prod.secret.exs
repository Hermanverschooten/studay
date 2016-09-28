use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :studay, Studay.Endpoint,
  secret_key_base: "rPHUT3WLT9x/ZeWQPkzhGRvIyNoPFv1ZQjkyKCQV0jyECdyGkp1gf/eKn5Vq3n6n"

# Configure your database
config :studay, Studay.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "studay_prod",
  pool_size: 20
