local root = (...):match("(.+)/.-")
return dofile(root .. "/piano.lua").createNoteskin(61, 1, root)
