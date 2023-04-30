class Generator(BaseGenerator):
    def data(self):
        # Catalog of 4 basic functions, make and identify composites

        # Variable name choices, 11 total
        vars = ['b', 'j', 'k', 'n', 's', 't', 'u', 'w', 'y', 'z']
        y = randrange(0,9)
        # Function name choices, 10 total
        funs = ['A', 'C', 'J', 'g', 'h', 'L', 'm', 'P', 'Q', 'R', 'V']

        while True:
            k = randrange(2,5)*choice([-1,1]) # f(x) = x + k
            l = randrange(1,4)*choice([-1,1]) # f(x) = l/x
            m = choice([2,3,5,6,7])*choice([-1,1]) # f(x) = mx, but ensure m is squarefree to avoid Sage's overzealous radical simplifications
            [i1,i2,i3,i4] = [randrange(0,10),randrange(0,10),randrange(0,10),randrange(0,10)]
            if( len([k,l,m]) == len(set([k,l,m])) and len([i1,i2,i3,i4]) == len(set([i1,i2,i3,i4])) ):
                break
        functions = [
            x + k, l/x, m*x, sqrt(x)
        ]
        ix = [i1,i2,i3,i4]
        shuffle(ix)
        fs = []
        ii = [0,1,2,3]
        #shuffle(ii)
        for i in ii:
            fs.append({"f":funs[ix[i]], "expr":functions[i]})

        while True:
            [ca,cb]=[randrange(0,3),randrange(0,4)]
            x1 = randrange(2,4)^2
            if(ca==1 and functions[cb].subs({x:x1})==0): # division by zero gonna happen
                continue
            if(ca!=cb):
                break
        c1 = [ fs[ca], fs[cb] ]
        ans0 = functions[cb].subs({x:x1})
        ans1 = functions[ca].subs({x:functions[cb].subs({x:x1})})

        # Options: 0,1 0,3
        j = choice([1,3])
        A = [[ fs[0], fs[j] ], [ fs[j],fs[0] ], [ fs[1], fs[1] ]]
        shuffle(A)
        [ca2,cb2,cc2] = A
        B=[{"expr": functions[0](x=functions[j])},{"expr": functions[j](x=functions[0])},{"expr": x} ]
        shuffle(B)
        c2 = B

        while True:
            [q1,q2,q3]=[randrange(0,4),randrange(0,4),randrange(0,4)]
            if( len([q1,q2,q3])==len(set([q1,q2,q3])) ):
                break
        exprvar = functions[q1](x=functions[q2](x=functions[q3], hold=True), hold=True)
        partb = [{'funcs': str(fs[0]['f'])+'('+str(fs[j]['f'])+'(x))', 'expr': functions[0](x=functions[j]) },
                 {'funcs': str(fs[j]['f'])+'('+str(fs[0]['f'])+'(x))', 'expr': functions[j](x=functions[0]) },
                 {'funcs': str(fs[1]['f'])+'('+str(fs[1]['f'])+'(x))', 'expr': x }
                ]
        partc = [fs[q1], fs[q2], fs[q3]]

        return {
            "functions": fs,
            "outer": c1[0]['f'],
            "c1": c1,
            "ca2":ca2,
            "cb2": cb2,
            "cc2": cc2,
            "c2": c2,
            "x1": x1,
            "expr2": c2,
            "var": vars[y],
            "exprvar": exprvar.subs({x:var(vars[y])}),
            "ans0": ans0,
            "ans1": ans1,
            'partb': partb,
            'partc': partc
        }