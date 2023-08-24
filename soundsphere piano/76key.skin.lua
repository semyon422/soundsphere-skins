local root = (...):match("(.+)/.-")
return dofile(root .. "/piano.lua").createNoteskin(76, 5, root)
