class Generator(BaseGenerator):
    def data(self):
        while True:     
            # b is denominator
            a = randrange(2,6)*choice([-1,1])
            b = randrange(3,8)
            c = randrange(3,9)
            d = randrange(2,4)*choice([-1,1])
            e = randrange(2,3)
            p = randrange(2,6)*randrange(1,6)*choice([-1,1])
            q = randrange(1,2)*choice([-1,1])

            # Exponent in answer

            n = QQ(( a*b + c - b*d*e )/b)
            # Coeff of answer
            m = QQ(p / q^e)

            if( n.denominator() > 1 and abs(n.numerator()) < n.denominator() ):
                break



        if( q==1 ):
            q = ''
        if( q==-1 ):
            q = '-'

        # Now part c

        while True:
            j = 2*randrange(2,9)
            k1 = 2*randrange(1,8)+1
            k2 = 2*randrange(1,8)+1
            s1 = choice([-1,1])
            s2 = -1*s1
            if(gcd(k1,k2) == 1):
                break


        # Build problem

        power = randrange(2,5)
        expr = QQ(m*power**(b*n))
        exprs = [ QQ(s1*j/k1), QQ(k1/k2), QQ(s2*k2/j)]
        shuffle(exprs)


        return {
            "expfloat": float(n),
            "expans": n,
            "num": n.numerator(),
            "den": n.denominator(),
            "coeff": m,
            "pow": power,
            "expr": expr,
            "expr1": exprs[0],
            "expr2": exprs[1],
            "expr3": exprs[2],
            "n1": exprs[0].numerator(),
            "d1": exprs[0].denominator(),
            "n2": exprs[1].numerator(),
            "d2": exprs[1].denominator(),
            "n3": exprs[2].numerator(),
            "d3": exprs[2].denominator(),
            "whichpos": QQ(s1*j/k1),
            "whichneg": QQ(k1/k2),
            "whichund": QQ(s2*k2/j),
            "a": a,
            "b": b,
            "c": c,
            "d": d,
            "e": e,
            "p": p,
            "q": q,
            "t": choice(['a','b','c','d','j','k','m','n','p','r','t','u','v','w','y','z']),
            "u": choice(['a','b','c','d','j','k','m','n','p','r','t','u','v','w','y','z']),
            "bpow": QQ(b*n)
        }