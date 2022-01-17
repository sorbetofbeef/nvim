-- Only allow symbols available in all Lua versions
std = "min"

-- Get rid of "unused argument self"-warnings
self = false

-- The unit tests can use busted
files["spec"].std = "+busted"

globals = {
    "PACKER_BOOTSTRAP",
    "vim",
}

-- Enable cache (uses .luacheckcache relative to this rc file).
cache = true

-- Do not enable colors to make the CI output more readable.
color = true

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
