class Generator(BaseGenerator):
    def data(self):
        funs = ['A','C','f','F','g','G','h','H','M','p','P','Q','r','R','T','V'] #16 options
        x = var('x')
        # Pick four factors, one of which will get turned around, and one of which may not be used.

        while True:
            [a,b,c,d] = [randrange(-6,6),randrange(-6,6),randrange(-6,6),randrange(-6,6)] # First one def numerator, last one def denominator.
            if( len([a,b,c,d]) == len(set([a,b,c,d])) and a*b*c*d != 0 ):
                break
        [q,r] = [randrange(0,4),randrange(0,4)] # The square-root-y factor and the squared factor (might be the same one!)

        X = [a,b,c,d]
        if(q==r and X[q] == 0): # Avoid sqrt(X^2) alone
            r = 3-r # Move the square to another factor

        factors = []
        for i in range(0,4):
            if( i==q and q!= r ):
                factors.append( sqrt(x-X[i]) )
            if( i==r and q!= r ):
                factors.append( x^2 + sign(X[i])*X[i]^2 )
            if( i==q and q==r ):
                factors.append( sqrt( x^2 + sign(X[i])*X[i]^2 ) )
            if( i!=q and i!= r ):
                factors.append( x - X[i] )

        expr = 1
        # Build expression skipping one of the linear factors
        while True:
            s = randrange(0,4)
            if( s!=q and s!=r ):
                break
        num = 1
        den = 1
        for i in range(0,4):
            if( i==q or i==r ):
                if(i<2):
                    expr *= factors[i]
                    num *= factors[i]
                else:
                    expr /= factors[i]
                    den *= factors[i]
            if( i!=q and i!=r and i != s):
                if(i<2):
                    expr *= factors[i]
                    num *= factors[i]
                else:
                    expr /= factors[i]
                    den *= factors[i]

        root = solve(num, x)
        pole = solve(den, x)

        roots = []
        for w in root:
            if( 'i' not in str(w.rhs()).lower() ):
                roots.append( w.rhs() )
        poles = []
        for w in pole:
            if( 'i' not in str(w.rhs()).lower() ):
                poles.append( w.rhs() )

        P = sorted(roots + poles)

        signchart = []
        vv = ''
        if( expr.subs({x:P[0]-1}).is_real() ):
            vv = sign( expr.subs({x:P[0]-1}))
        else:
            vv = '\\text{und}'
        signchart.append( {"int": '(-\\infty,'+str(P[0])+')', "sign": vv } )

        for j in range(0,len(P)):
            p = P[j]
            if(p in roots and den.subs({x:p}).is_real()):
                s = '\\circ'
            if(p in poles or not den.subs({x:p}).is_real() ):
                s = '\\text{und}'
            signchart.append( {"int": p, "sign": s})
            if( j==len(P)-1 ):
                rr = '\\infty'
                rrr = p + 1
            else:
                rr = P[j+1]
                rrr = rr
            vv = ''
            if( den.subs({ x: (p+rrr)/2 })!= 0 and expr.subs({ x: (p+rrr)/2 }).is_real() ):
                vv = sign( expr.subs({ x: (p+rrr)/2 }))
            else:
                vv = '\\text{und}'
            signchart.append( {"int": '('+str(p)+','+str(rr)+')', "sign": vv})

        for k in signchart:
            if(k['sign'] == 1):
                k['sign'] = '+'
            if(k['sign'] == -1):
                k['sign'] = '-'


        xint = []
        for xx in roots:
            if( xx not in poles and den.subs({x:xx}).is_real() ):
                xint.append( {"x": xx} )
        yint = []
        if( num.subs({x:0}).is_real() and den.subs({x:0}).is_real() and den.subs({x:0}) != 0 ):
            yint.append( {"y": expr.subs({x:0})} )

        if( signchart[0]['sign'] == '\\text{und}' ):
            dom = ''
            inclu = False
        else:
            dom = '(-\\infty'
            inclu = True
        for k in range(1,len(signchart)-1,2):
            if( inclu and signchart[k]['sign'] == '\\text{und}' ): # soft right boundary
                dom += ','+str(signchart[k]['int'])+')'
                inclu = False
            if( inclu and signchart[k]['sign'] == '\\circ' and signchart[k+1]['sign'] == '\\text{und}' ): # hard right boundary
                dom += ','+str(signchart[k]['int'])+']'
                inclu = False
            if( not inclu and signchart[k]['sign'] == '\\text{und}' and signchart[k+1]['sign'] != '\\text{und}'): # soft left boundary
                if( dom != ''):
                    dom += '\\cup'
                dom += '('+str(signchart[k]['int'])
                inclu = True
            if( not inclu and signchart[k]['sign'] == '\\circ' and signchart[k+1]['sign'] != '\\text{und}'): # hard left boundary
                if( dom != ''):
                    dom += '\\cup'
                dom += '['+str(signchart[k]['int'])
                inclu = True

        if( inclu ):
            dom += ',\\infty)'

        yround = ''
        if( len(yint) > 0 and not yint[0]['y'] in QQ ):
            yround = '\\approx (0,'+str(n(yint[0]['y'],digits=4))+')'

        if( len(xint) == 0 ):
            xints = ''
        else:
            xints = xint
        if( len(yint) == 0 ):
            yints = ''
        else:
            yints = yint

        return {
            "f": funs[randrange(0,16)],
            "expr": expr,
            "roots": roots,
            "poles": poles,
            "signchart": signchart,
            "xn": len(xint),
            "yn": len(yint),
            "xint": xints,
            "yint": yints,
            "dom": dom,
            "yround": yround
        }