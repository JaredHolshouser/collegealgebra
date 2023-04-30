class Generator(BaseGenerator):
    def data(self):
        names =['Abigail','Brian','Carlos','Desiree','Ethan','Federico','Grant','Hailey','Indira','Jillian','Kai','Lucas','Maria','Natasha','Owen','Piero','Quinn','Riley','Santiago','Tucker','Ursula','Vincent','Werner','Xaviera','Yasmin','Zaya']
        pronouns =['she','he','he','she','he','he','he','she','she','she','they','he','she','she','he','he','they','she','he','they','she','she','he','she','she','they']
        possessives = ['her','his','his','her','his','his','his','her','her','her','their','his','her','her','his','his','their','her','his','their','her','her','his','her','her','their']
        i = randrange(0,26)
        suffix = 's'
        if(pronouns[i] == 'they'):
            suffix = ''
        vars = ['t', 'u', 'w', 'x', 'y', 'z']
        k = randrange(0,6)
        X = var(vars[k])

        # Choose factors of original LHS
        r = [0,0]
        while True:
            r = [QQ(randrange(1,8)/randrange(2,4))*choice([-1,1]),randrange(1,7)*choice([-1,1])]
            if( r[0].denominator() != 1 ):
                break
        ABC = [ r[0].denominator(), -r[0].denominator()*r[1] - r[0].numerator(), r[1]*r[0].numerator() ]    
        Delta = ABC[1]^2 - 4*ABC[0]*ABC[2]

        # Pick a factoring-compatible RHS
        while True:
            L = randrange(1,20)
            if( Mod(Delta - L^2, 4*ABC[0])==0 and Delta != L^2 ):
                break

        lhs1 = ABC[0]*X^2 + ABC[1]*X + ABC[2]
        rhs1 = -round((Delta - L^2)/4/ABC[0],0)

        fac1 = r[0].denominator()*X - r[0].numerator()
        fac2 = X-r[1]

        rr = [QQ((-ABC[1]-L)/2/ABC[0]), QQ((-ABC[1]+L)/2/ABC[0])]

        cfac1 = rr[0].denominator()*X - rr[0].numerator()
        cfac2 = rr[1].denominator()*X - rr[1].numerator()

        lhs2 = ABC[0]*X^2 + ABC[1]*X + ABC[2] - rhs1

        # Pick an almost-but-not-quite-perfect-square-compatible RHS

        Delta2 = Delta
        ii=0
        while True:
            Delta2 += 4*ABC[0]
            ii += 1
            if( (not Delta2.is_square()) and Delta2 != factor(Delta2).radical_value() ):
                break
        rhs2 = ii
        Delta2 = ABC[1]^2 - 4*ABC[0]*(ABC[2]-rhs2)

        Q = solve(ABC[0]*x^2 + ABC[1]*x + ABC[2]-rhs2 == 0, x)

        lhs3 = ABC[0]*X^2 + ABC[1]*X + ABC[2]-rhs2
        if(ABC[2]-rhs2 > 0):
            sgn = "+"
        if(ABC[2]-rhs2 < 0):
            sgn = '-'

        prefac = X^2 + ABC[1]/ABC[0]*X
        extraterm = (ABC[1]/ABC[0]/2)^2
        if(ABC[2]-rhs2-ABC[0]*extraterm > 0):
            sgna="+"
        if(ABC[2]-rhs2-ABC[0]*extraterm < 0):
            sgna = "-"
        fac3 = X + ABC[1]/ABC[0]/2

        return {
            "stu": names[i],
            "pn": pronouns[i],
            "pos": possessives[i],
            "suf": suffix,
            "var": X,
            "lhs1": lhs1,
            "rhs1": rhs1,
            "fac1": fac1,
            "fac2": fac2,
            "wrong1": r[0]+rhs1,
            "wrong2": r[1]+rhs1,
            "cfac1": cfac1,
            "cfac2": cfac2,
            "sol1": rr[0],
            "sol2": rr[1],
            "lhs2": lhs2,
            "rhs2": rhs2,
            "origdisc": Delta,
            "i": i,
            "disc": Delta2,
            "facs": factor(Delta2),
            "A": ABC[0],
            "B": ABC[1],
            "MB": -ABC[1],
            "sgn": sgn,
            "C": abs(ABC[2]-rhs2),
            "prefac3": prefac,
            "extra": extraterm,
            "extraa": ABC[0]*extraterm,
            "sol3": Q[0].rhs(),
            "sol4": Q[1].rhs(),
            "lhs3": lhs3,
            "fac3": fac3,
            "CC": abs(ABC[2]-rhs2-ABC[0]*extraterm),
            "sgna": sgna,
            "CCn": -(ABC[2]-rhs2-ABC[0]*extraterm)/ABC[0],
            "AB": -ABC[1]/ABC[0]/2

        }