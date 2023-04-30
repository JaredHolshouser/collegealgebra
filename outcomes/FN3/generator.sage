class Generator(BaseGenerator):
    def data(self):
        # Variable name choices, 12 total
        vars = ['b', 'j', 'k', 'n', 's', 't', 'u', 'w', 'x', 'y', 'z']
        # Function name choices, 10 total
        funs = ['A', 'C', 'f', 'g', 'h', 'L', 'M', 'P', 'Q', 'R', 'V']


        i = randrange(0,11)
        k = randrange(0,10)

        # Select some parameter values
        while True:
            a = randrange(2,4)*choice([-1,1])
            b = randrange(2,8)
            c = randrange(1,8)*choice([-1,1])
            if( abs(a)!=abs(b) and a!=c and b!=c ):
                break
        X = var(vars[i])
        fac1 = X - b
        fac2 = X + b
        fac5 = X + c
        sgnc = ''
        if(c > 0):
            sgnc = '+'
        if(c < 0):
            sgnc = '-'

        # Select an expression
        exprs = [
            a*fac1^2 + c,
            -abs(a)*X^2 + X*fac2,
            a - b*fac5^2
        ]
        exprtext = [
            str(a)+"("+str(fac1)+")^2 "+sgnc+str(abs(c)),
            "-"+str(abs(a))+str(vars[i])+"^2 + "+str(vars[i])+"("+str(fac2)+")",
            str(a)+" - "+str(b)+"("+str(fac5)+")^2"
        ]
        l = randrange(0,3)

        points = []
        pointss = []

        # Pick five sequential iv values, checking that the missing one has a "nice" solution
        while True:
            x = [randrange(1,8)*choice([-1,1]),randrange(1,8)*choice([-1,1]),randrange(1,8)*choice([-1,1]),randrange(1,8)*choice([-1,1]),randrange(1,8)*choice([-1,1])]
            if( len(x) == len(set(x)) ):
                break

        x.sort()
        j0 = randrange(0,5)

        for j in range(0,5):
            if( j == j0 ):
                points.append( { "x": '\\boxed{\\rule{3ex}{0pt}\\rule{0pt}{2ex}}', "y": exprs[l].subs({X: x[j]}) } )
                pointss.append( { "x": x[j], "y": exprs[l].subs({X:x[j]})} )
            else:
                points.append( { "x": x[j], "y": '\\boxed{\\rule{3ex}{0pt}\\rule{0pt}{2ex}}' } )
                pointss.append( { "x": x[j], "y": exprs[l].subs({X:x[j]})} )
        
        xmax = max( abs(pointss[r]["x"]) for r in range(5) )
        ymax = max( abs(pointss[r]["y"]) for r in range(5) )
        xmin = max(xmax, ymax)
        
        pts = [tuple([pointss[r]["x"],pointss[r]["y"]]) for r in range(5)]

        return {
            "expr": exprtext[l],
            "exprr": exprs[l],
            "points": points,
            "pointss": pointss,
            "xmax": 1.25*xmax,
            "ymax": 1.25*ymax,
            "f": funs[k],
            "iv": vars[i],
            "pts": pts
        }
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "graph": plot(data['exprr'], data['iv'],-1*data['xmax'],data['xmax'])+point(data['pts'],xmin=-1*data['xmax'],xmax=data['xmax'],ymin=-1*data['ymax'],ymax=data['ymax'],size=48,color='black',axes_labels=[data['iv'],data['f']+"("+data['iv']+")"])
            }