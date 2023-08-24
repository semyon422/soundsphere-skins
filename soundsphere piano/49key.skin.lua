local root = (...):match("(.+)/.-")
return dofile(root .. "/piano.lua").createNoteskin(49, 1, root)
