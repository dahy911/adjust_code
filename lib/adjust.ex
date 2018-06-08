defmodule Adjust do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Adjust.RepoBar, []),
      supervisor(Adjust.RepoFoo, []),
      Plug.Adapters.Cowboy.child_spec(:http, Adjust.Routes, [], port: 8080)
    ]

    opts = [strategy: :one_for_one, name: Adjust.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
