local root = (...):match("(.+)/.-")
return dofile(root .. "/piano.lua").createNoteskin(48, 1, root)
