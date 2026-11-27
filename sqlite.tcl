package require tdbc::sqlite3
namespace eval ::tpersist_sqlite {namespace export connection_options connect}

proc ::tpersist_sqlite::connection_options {config} {
    set options [dict create -database [dict get $config sqlite_path]]
    if {[dict exists $config sqlite_timeout]} {dict set options -timeout [dict get $config sqlite_timeout]}
    if {[dict exists $config sqlite_wal]} {dict set options -wal [dict get $config sqlite_wal]}
    return $options
}

proc ::tpersist_sqlite::connect {options} {
    if {![dict exists $options -database] || [dict get $options -database] eq {}} {
        return -code error -errorcode {TCL WRONGARGS} "SQLite requires -database (use :memory: for an in-memory database)"
    }
    set path [dict get $options -database]
    set wal [expr {[dict exists $options -wal] && [dict get $options -wal]}]
    set db [::tdbc::sqlite3::connection new $path {*}[dict remove $options -database -wal]]
    try {
        if {$wal} {
            set mode [dict get [lindex [$db allrows {PRAGMA journal_mode = WAL} {}] 0] journal_mode]
            if {$mode ne "wal"} {error "SQLite could not enable WAL mode"}
        }
        $db allrows {PRAGMA foreign_keys = ON} {}
    } on error {message opts} {
        catch {$db close}
        return -options $opts $message
    }
    return $db
}

package provide tpersist-sqlite 0.1.9
