# tpersist-sqlite

`::tpersist_sqlite::connection_options config` reads the SQLite path from `sqlite_path`.

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
