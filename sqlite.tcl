package require tdbc::sqlite3
namespace eval ::tpersist_sqlite {namespace export connection_options connect}

proc ::tpersist_sqlite::connection_options {config} {
    return [dict create -database [dict get $config sqlite_path]]
}

proc ::tpersist_sqlite::connect {options} {
    if {![dict exists $options -database] || [dict get $options -database] eq {}} {
        return -code error -errorcode {TCL WRONGARGS} "SQLite requires -database (use :memory: for an in-memory database)"
    }
    set path [dict get $options -database]
    set db [::tdbc::sqlite3::connection new $path {*}[dict remove $options -database]]
    try {
        $db allrows {PRAGMA foreign_keys = ON} {}
    } on error {message opts} {
        catch {$db close}
        return -options $opts $message
    }
    return $db
}

package provide tpersist-sqlite 0.1.8
