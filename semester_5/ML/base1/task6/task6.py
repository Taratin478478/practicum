def check(x: str, file: str):
    d = dict()
    l = list(w.lower() for w in x.split())
    for w in sorted(set(l)):
        d[w] = l.count(w);
    f = open(file, 'w')
    for k, v in d.items():
        print(k, v, file=f)  
    f.close()
    
