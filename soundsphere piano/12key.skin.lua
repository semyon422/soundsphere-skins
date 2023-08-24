local root = (...):match("(.+)/.-")
return dofile(root .. "/piano.lua").createNoteskin(12, 1, root)
