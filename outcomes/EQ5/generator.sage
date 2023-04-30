class Generator(BaseGenerator):
    def data(self):
        vars = ['t', 'u', 'v', 'w', 'x', 'y', 'z']
        k = randrange(0,7)
        X = var(vars[k])

        # Choose four distinct factors, one of which has noninteger root, we'll use it and 2-3 others.
        while True:
            r = [QQ(randrange(1,8)/randrange(1,5)*choice([-1,1])), randrange(1,9)*choice([-1,1]),randrange(1,9)*choice([-1,1]),randrange(1,9)*choice([-1,1])]
            if( r[0].denominator()>=2 and sign(product(r))==-1 and (r[1]-r[2])*(r[1]-r[3])*(r[2]-r[3]) != 0 ):
                break
        factors = [ X*r[0].denominator()-r[0].numerator(), (X-r[1])^2, X-r[2], X-r[3] ]
        allzeroes = r
        temp = list(zip(factors,allzeroes))
        shuffle(temp)
        factors, allzeroes = zip(*temp)


        # Distribute into numerator and denominator
        b = randrange(1,3) # How many numerator factors
        expr = 1
        zeroes = []
        poles = []
        for i in range(0,4):
            if(i<b): # Numerator
                expr *= factors[i]
                zeroes.append(allzeroes[i])
            if(i>=b): # Denominator
                expr /= factors[i]
                poles.append(allzeroes[i])
        direc = choice(['lt','gt'])
        strict = choice([True,False])

        if(direc == 'lt'):
            if(strict):
                ineq = '<'
            if(not strict):
                ineq = '\\leq'
        if(direc == 'gt'):
            if(strict):
                ineq = '>'
            if(not strict):
                ineq = '\\geq'            

        az = list(allzeroes)
        az.sort()
        testpoints = [az[0]-1]
        for i in range(0,3):
            testpoints.append( (az[i]+az[i+1])/2 )
        testpoints.append(az[3]+1)

        signs= []

        for i in range(0,5):
            if( sign(expr.subs({X:testpoints[i]})) > 0 ):
                signs.append('+')
            else:
                signs.append('-')

        zp = []

        for i in range(0,4):
            if( az[i] in zeroes ):
                zp.append('\\circ')
            else:
                zp.append('\\infty')

        sol = ''
        if(direc=='lt'):
            watch = '-'
        if(direc=='gt'):
            watch = '+'

        if(signs[0] == watch):
            sol += '(-\\infty,'+str(az[0])
            if( (not strict) and (az[0] in zeroes) ):
                sol += ']'
            else:
                sol += ")"
        for i in range(1,4):
            if(signs[i] == watch):
                if(not sol==''): # Need a union symbol
                    sol += '\\cup '
                if( (not strict) and (az[i-1] in zeroes) ):
                    sol += '['
                else:
                    sol += "("
                sol += str(az[i-1])+","+str(az[i])
                if( (not strict) and (az[i] in zeroes) ):
                    sol += ']'
                else:
                    sol += ')'
        if(signs[4] == watch):
            if(not sol==''): # Need a union symbol
                    sol += '\\cup '
            if( (not strict) and (az[3] in zeroes) ):
                sol += '['
            else:
                sol += '('
            sol += str(az[3])+',\\infty )'



        return {
            "expr": expr,
            "exprs": expr.numerator().expand()/expr.denominator().expand(),
            "ineq": ineq,
            "numeratorfactors": b,
            "var": vars[k],
            "zeroes": zeroes,
            "poles": poles,
            "allzeroes": az,
            "s0": signs[0],
            "s1": signs[1],
            "s2": signs[2],
            "s3": signs[3],
            "s4": signs[4],
            "z0": az[0],
            "z1": az[1],
            "z2": az[2],
            "z3": az[3],
            "p0": zp[0],
            "p1": zp[1],
            "p2": zp[2],
            "p3": zp[3],
            "sol": sol
        }