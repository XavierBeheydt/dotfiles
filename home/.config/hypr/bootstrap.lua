-- Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

-------------------
---- BOOTSTRAP ----
-------------------

local home = os.getenv("HOME")

package.path =
  home .. "/.config/?.lua;"
  .. package.path

return {
    home = home
}
