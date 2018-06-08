# Adjust

## Getting Started

* Get dependencies: `mix deps.get`
* Compile: `mix compile`


## Running
* change config file for database information
*  set config property at  RepoBar path: "C:\\mylog"
* Start iex: `iex -S mix`
* add data to source table in Foo database: `Adjust.Query.add_data()`
* copy data from foo database source table to bar database to dest table: `Adjust.Query.copy()`
* call the http://localhost:8080/dbs/foo/tables/source using your browser
* call the http://localhost:8080/dbs/foo/tables/source
