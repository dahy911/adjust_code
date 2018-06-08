defmodule Adjust.Query do
  import Ecto.Query

  @path1 Application.get_env(:adjust, Adjust.RepoBar)[:path]
  def test() do
    # read config
    IO.puts(@path1)
  end

  # add data to source table
  def add_data() do
    Enum.each(1..1_000_000, fn x ->
      a = x |> Integer.to_string()

      b = rem(x, 3) |> Integer.to_string()
      c = rem(x, 5) |> Integer.to_string()
      # a
      qry = "insert into source values(" <> a <> "," <> b <> "," <> c <> ")"
      Ecto.Adapters.SQL.query!(Adjust.RepoFoo, qry, [])
    end)
  end

  def get_Source() do
    path = @path1 <> "\\data_src.csv"
    File.rm(path)
    exp = "  COPY source TO '" <> path <> " ' DELIMITER ',' ;"
    res = Ecto.Adapters.SQL.query!(Adjust.RepoFoo, exp, [])
  end

  def get_Dest() do
    path = @path1 <> "\\data_dest.csv"
    File.rm(path)
    exp = "  COPY Dest TO '" <> path <> "' DELIMITER ',' ;"
    Ecto.Adapters.SQL.query!(Adjust.RepoBar, exp, [])
  end

  def copy() do
    path = @path1 <> "\\data_exp.csv"
    File.rm(path)
    exp = "  COPY source TO '" <> @path1 <> "\\data_exp.csv ' DELIMITER ',' ;"
    Ecto.Adapters.SQL.query!(Adjust.RepoFoo, exp, [])
    # C:\\
    qry = "COPY dest FROM '" <> path <> "' DELIMITERS ',' CSV QUOTE '''';"
    # a
    Ecto.Adapters.SQL.query!(Adjust.RepoBar, qry, [])
  end
end
