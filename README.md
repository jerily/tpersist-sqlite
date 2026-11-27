# tpersist-sqlite

`::tpersist_sqlite::connection_options config` reads the SQLite path from `sqlite_path`. Optional `sqlite_timeout` sets the busy timeout in milliseconds. Set `sqlite_wal` to true when initializing a file-backed database to enable persistent write-ahead logging.

`::tpersist_sqlite::connect options` takes a Tcl dictionary of SQLite connection options and returns an open TDBC connection in the current interpreter. The caller owns and closes it.

```tcl
package require tpersist-sqlite
set db [::tpersist_sqlite::connect {-database :memory:}]
try {
    $db allrows {SELECT 1} {}
} finally {
    $db close
}
```
