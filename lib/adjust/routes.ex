defmodule Adjust.Routes do
  use Plug.Router
  @path1 Application.get_env(:adjust, Adjust.RepoBar)[:path]
  plug(:match)
  plug(:dispatch)

  get "dbs/foo/tables/source" do
    # data =
    # ("Hello World Dahy!" <> File.read!("users.csv"))

    Adjust.Query.get_Source()

    conn
    |> put_resp_header("content-type", "application/json")
    |> put_resp_content_type("text/csv")
    # |> send_chunked(200)
    |> send_resp(200, File.read!(@path1 <> "\\data_src.csv"))

    #    conn
    #    |> put_resp_header("content-type", "application/json")
    # |> send_resp(200, Poison.encode!(Adjust.Query.get_locations()))
  end

  get "dbs/bar/tables/dest" do
    # data =
    # ("Hello World Dahy!" <> File.read!("users.csv"))

    Adjust.Query.get_Source()

    conn
    |> put_resp_header("content-type", "application/json")
    |> put_resp_content_type("text/csv")
    # |> send_chunked(200)
    |> send_resp(200, File.read!(@path1 <> "\\data_src.csv"))

    #    conn
    #    |> put_resp_header("content-type", "application/json")
    # |> send_resp(200, Poison.encode!(Adjust.Query.get_locations()))
  end

  match _ do
    send_resp(conn, 404, "you shall not pass")
  end
end
