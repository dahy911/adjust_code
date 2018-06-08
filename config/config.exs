# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :adjust, ecto_repos: [Adjust.RepoBar, Adjust.RepoFoo]

config :adjust, Adjust.RepoBar,
  adapter: Ecto.Adapters.Postgres,
  database: "bar",
  hostname: "localhost",
  username: "postgres",
  password: "root",
  port: "5432",
  path: "C:\\mylog",
  types: Adjust.PostgresTypes

config :adjust, Adjust.RepoFoo,
  adapter: Ecto.Adapters.Postgres,
  database: "foo",
  hostname: "localhost",
  username: "postgres",
  password: "root",
  port: "5432",
  types: Adjust.PostgresTypes
