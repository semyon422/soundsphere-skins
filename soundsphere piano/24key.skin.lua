local root = (...):match("(.+)/.-")
return dofile(root .. "/piano.lua").createNoteskin(24, 1, root)
