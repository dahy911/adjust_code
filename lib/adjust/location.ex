defmodule Adjust.Location do
  use Ecto.Schema

  schema "locations" do
    field(:name)
    field(:geom)
  end
end
