def find_modified_max_argmax(L, f):
    l = list(map(f, [x for x in L if type(x) == int]))
    if (l):
        m = max(l)
        return (m, l.index(m))
    return ()
    