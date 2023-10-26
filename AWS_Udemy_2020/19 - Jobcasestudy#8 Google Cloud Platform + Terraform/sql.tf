#Basado en: https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11064146#questions

#Preparamos: 2x instancias, la principal 'Master' y la 'Replica' + 1 usuario que pueda acceder a ella y como output la IP de la instancia

resource "google_sql_database_instance" "master" {
  name = "${var.pname}-s"
  database_version = "${var.db_version}"
  region = "${var.region}"

  settings {
    tier = "${var.sql_tier}"
    disk_size = "${var.db_disk_size}"

    backup_configuration {
            binary_log_enabled = true
            enabled = true
            start_time = "06:00"
        }
    ip_configuration = {
        authorized_networks = {
                name = "The Network"
                value = "${var.authorized_network}"
            }
      }
    }
}


resource "google_sql_database_instance" "sql_replica" {
  name = "${var.pname}-replicaa"
  region               = "${var.region}"
  database_version     = "${var.db_version}"
  master_instance_name = "${google_sql_database_instance.master.name}"

  replica_configuration {
    connect_retry_interval = "${var.connect_retry_interval}"
    failover_target        = "true"
  }

  settings {
    tier                        = "${var.sql_tier}"
    disk_size                   = "${var.db_disk_size}"
    crash_safe_replication      = "true"
  }
}


resource "google_sql_user" "users" {
  name     = "${var.db_user_name}"
  instance = "${google_sql_database_instance.master.name}"
  host     = "%"
  password = "${var.db_user_password}"
}


output "db_ip" {
  value = "${google_sql_database_instance.master.ip_address.0.ip_address}"
}
