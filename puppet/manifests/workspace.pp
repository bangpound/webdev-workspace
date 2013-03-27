Exec { path => [
    "/usr/local/sbin",
    "/usr/local/bin",
    "/usr/sbin",
    "/usr/bin",
    "/sbin:/bin",
  ]
}

import "classes/*"

include linux_common
include drupal
