class Generator(BaseGenerator):
    def data(self):
        [solx,soly] = [randrange(-8,8)*choice([-1,1]), randrange(-8,8)*choice([-1,1])]
        soltype = randrange(1,8)
        var('x y')
        if(soltype < 7): # Unique solution
            while True:
                [a,b,c,d] = [randrange(1,5)*choice([-1,1]),randrange(1,5)*choice([-1,1]),randrange(1,5)*choice([-1,1]),randrange(1,5)*choice([-1,1])]
                if(a*d-b*c != 0 and len(set(map(abs,[a,b,c,d])))>2 ):
                    break
            kind = "a unique solution, "
            [rhs1,rhs2] = [a*solx + b*soly, c*solx+d*soly]
            sol = '(x,y) = ('+str(solx)+','+str(soly)+')'
            if( (b/a)*(d/c) < 0 ): # Slopes have opposite signs
                graphtype = "image (2). One line has positive slope and the other has negative slope, so they have a unique point of intersection."
            else:
                if( b/a > 0 ):  # Both lines negative slope
                    graphtype = "image (3). Both lines have negative, but unequal, slopes. There is a unique point of intersection."
                else:
                    graphtype = "image (1). Both lines have positive, but unequal, slopes. There is a unique point of intersection."
        if(soltype >= 7): # No solution (7) or coincident (8)
            while True:
                [a,b] = [randrange(1,8)*choice([-1,1]), randrange(2,9)*choice([-1,1])]
                if( abs(a) != abs(b) and gcd(abs(a),abs(b)) == 3 ):
                    break

            k = choice([-4,-2,-1,2,4])
            [c,d] = [k*a/3,k*b/3]
            if(soltype == 7): # No solution
                [rhs1,rhs2] = [a*solx+b*soly,a/3*solx+b/3*soly]
                kind = "no solution."
                sol = ''
                if( b/a > 0 ): # Negative slopes, parallel
                    graphtype = "image (6). Both lines have negative, equal slopes. They are parallel and distinct, having no point of intersection."
                else:
                    graphtype = "image (4). Both lines have positive, equal slopes. They are parallel and distinct, having no point of intersection."
            else:
                # If lines coincident, need both positive slope.
                s = choice([-1,1])
                t = choice([-1,1])
                [a,b,c,d] = [s*abs(a),-s*abs(b),t*abs(c),-t*abs(d)]
                [rhs1,rhs2] = [a*solx+b*soly,c*solx+d*soly]
                kind = "infinitely many solutions."
                sol = ''
                graphtype = "image (5). Both lines have positive, equal slopes and are in fact coincident (the same line), sharing all of their infinitely many points."

        return {
            "lhs1": a*x + b*y,
            "rhs1": rhs1,
            "lhs2": c*x+d*y,
            "rhs2": rhs2,
            "sol": sol,
            "kind": kind,
            "graphtype": graphtype
        }