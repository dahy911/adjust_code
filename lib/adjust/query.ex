defmodule Adjust.Query do
  import Ecto.Query
  @columns ~w(  a b c )a
  @path1 Application.get_env(:adjust, Adjust.RepoBar)[:path]
  def test() do
    # read config
    IO.puts(@path1)
  end

  def add_data() do
    #    avalu = 20
    #    data = %Adjust.Source{id: 1, a: avalu, b: 99, c: 88}
    # Adjust.RepoFoo.insert!(data)
    Enum.each(1..1_000_000, fn x ->
      a = x |> Integer.to_string()

      b = rem(x, 3) |> Integer.to_string()
      c = rem(x, 5) |> Integer.to_string()
      # a
      qry = "insert into source values(" <> a <> "," <> b <> "," <> c <> ")"
      Ecto.Adapters.SQL.query!(Adjust.RepoFoo, qry, [])

      # IO.puts(qry)
    end)
  end

  def get_Source() do
    path = @path1 <> "\\data_src.csv"
    File.rm(path)

    Adjust.RepoFoo.transaction(fn ->
      from(
        l in Adjust.Source,
        select: %{a: l.a, b: l.b, c: l.c}
      )
      |> Adjust.RepoFoo.stream()
      |> Stream.map(&parse_line/1)
      |> CSV.encode()
      |> Enum.into(File.stream!(path, [:write, :utf8]))
    end)
  end

  def get_Dest() do
    path = @path1 <> "\\data_dest.csv"
    File.rm(path)

    Adjust.RepoBar.transaction(fn ->
      from(
        l in Adjust.Dest,
        select: %{a: l.a, b: l.b, c: l.c}
      )
      |> Adjust.RepoBar.stream()
      |> Stream.map(&parse_line/1)
      |> CSV.encode()
      |> Enum.into(File.stream!(path, [:write, :utf8]))
    end)
  end

  def copy() do
    path = @path1 <> "\\data_exp.csv"
    File.rm(path)
    exp = "  COPY source TO '" <> @path1 <> "\\data_exp.csv ' DELIMITER ',' ;"
    res = Ecto.Adapters.SQL.query!(Adjust.RepoFoo, exp, [])
    # C:\\
    qry = "COPY dest FROM '" <> path <> "' DELIMITERS ',' CSV QUOTE '''';"
    # a
    res = Ecto.Adapters.SQL.query!(Adjust.RepoBar, qry, [])
    res
  end

  defp parse_line(location) do
    # order our data to match our column order
    Enum.map(@columns, &Map.get(location, &1))
  end
end
