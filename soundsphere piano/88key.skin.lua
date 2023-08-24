local root = (...):match("(.+)/.-")
return dofile(root .. "/piano.lua").createNoteskin(88, 10, root)
