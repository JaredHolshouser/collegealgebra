class Generator(BaseGenerator):
    def data(self):
        import re
        # Select four x-coordinates in [-8,8] for features 
        while True:
            r = sorted([randrange(-8,8),randrange(-8,8),randrange(-8,8),randrange(-8,8)])
            gaps = [r[1]-r[0],r[2]-r[1],r[3]-r[2]]
            if(min(gaps) >= 2):
                break

        fs = []
        var('x')
        num(x) = 1
        den(x) = 1
        ix = [0,1,2,3]
        shuffle(ix)
        num(x) = num(x)*(x-r[ix[0]])
        fs.append({ 'feature': 'an x-intercept', 'x': r[ix[0]]})
        den(x) = den(x)*(x-r[ix[1]])
        fs.append({ 'feature': 'a vertical asymptote', 'x': r[ix[1]]})
        if(choice([True,False])):
            num(x) = num(x)*(x-r[ix[2]])
            fs.append({ 'feature': 'an x-intercept', 'x': r[ix[2]]})
        else:
            den(x) = den(x)*(x-r[ix[2]])
            fs.append({ 'feature': 'a vertical asymptote', 'x': r[ix[2]]})
        ggb1 = 'L=Segment((-10,0),(10,0));Segment((0,-10),(0,10));'

        for k in [0,1,2]:
            ggb1 += "Text(\""+str(r[ix[k]])+"\",("+str(r[ix[k]])+",-0.4));"

        ggb1 += re.sub(r'\+','--',re.sub(r'\^','**',re.sub(r'\s','','('+str(num(x).full_simplify())+')*('+str(den(x).full_simplify())+")**(-1);")))
        numhs(x) = (num(x)*(x-r[ix[3]])).full_simplify()
        denhs(x) = (den(x)*(x-r[ix[3]])).full_simplify()
        hy = QQ(num(r[ix[3]])/den(r[ix[3]]))
        ggb2 = ggb1 + "("+str(r[ix[3]])+","+str(hy)+");Text(\""+str(r[ix[3]])+"\",("+str(r[ix[3]])+",-0.4));"

        return {
            "features": fs,
            "hx": r[ix[3]],
            "hy": hy,
            "num": num(x),
            "den": den(x),
            "nums": num(x).full_simplify(),
            "dens": den(x).full_simplify(),
            "numh": num(x)*(x-r[ix[3]]),
            "denh": den(x)*(x-r[ix[3]]),
            "numhs": numhs(x),
            "denhs": denhs(x),
            "ggb1": ggb1,
            "ggb2": ggb2
        }
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "graph1": plot(data['num']/data['den'],(x,-10,10),ymin=-10,ymax=10,detect_poles='show'),
            "graph2": plot(data['num']/data['den'],(x,-10,10),ymin=-10,ymax=10,detect_poles='show',zorder=10)+point([(data['hx'],data['hy'])],size=60,markeredgecolor='blue',color='white',zorder=15)
        }
