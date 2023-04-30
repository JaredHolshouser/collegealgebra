class Generator(BaseGenerator):
    def data(self):
        names = ['Abigail','Brian','Carlos','Desiree','Ethan','Federico','Grant','Hailey','Indira','Jillian','Kai','Lucas','Maria','Natasha','Owen','Piero','Quinn','Riley','Santiago','Tucker','Ursula','Vincent','Werner','Xaviera','Yadier','Zaya']
        pronouns = ['she','he','he','she','he','he','he','she','she','she','they','he','she','she','he','he','they','she','he','they','she','she','he','she','she','they']
        pospronouns = ['her','his','his','her','his','his','his','her','her','her','their','his','her','her','his','his','their','her','his','they','her','her','his','her','her','their']

        k=randrange(0,26) # Select student name and pronouns

        while True:
            a = randrange(2,7)
            b = randrange(1,9)*choice([-1,1])
            c = randrange(1,9)
            d = randrange(3,7)*choice([-1,1])
            if(c*d^2 <= 100):
                break

        s1 = '+'
        if(b<0):
            s1 = '-'
        s2 = '+'
        if(d<0):
            s2 = '-'
        reasons = ['distributing the square across the addition/subtraction on step 1, omitting the "cross term"','incorrectly applying an exponent property (x^2 times x is not x^2)','incorrectly changing the variable factor when combining '+str(b)+'x^2 - '+str(c)+'x^2 terms','forgetting to distribute the negative sign on the coefficient '+str(c)]

        var('x')
        expr = x^2*( a*x + b ) - c*(x + d)^2
        wrongs = [ x^2*( a*x + b ) - c*(x^2 + d^2), a*x^2 + b*x^2 - c*(x+d)^2, a*x^3 - 2*c*d*x - c*d^2 + b - c, a*x^3 + (b-c)*x^2 + 2*c*d*x + c*d^2 ]

        j = randrange(0,4)
        wexpr = wrongs[j].expand()


        # Now build the factoring question

        while True:
            n = randrange(1,5)*choice([-1,1])
            m = randrange(2,5)
            p = randrange(1,5)*choice([-1,1])
            if(n != p and gcd(n,m)==1):
                break

        expr2 = m*x^2 - (n+m*p)*x + n*p
        wrongfactors = [ m*(x-n)*(x-p), (m*x-p)*(x-n), (m*x+p)*(x+n), (m*x+n)*(x+p) ]
        l = randrange(0,4)
        wexpr2 = wrongfactors[l]

        return {
            "stu": names[k],
            "pn": pronouns[k],
            "ppn": pospronouns[k],
            "a": a,
            "b": abs(b),
            "c": c,
            "d": abs(d),
            "s1": s1,
            "s2": s2,
            "p": abs(p),
            "ans1": expr.expand(),
            "wexpr": wexpr,
            "reason1": reasons[j],
            "expr2": expr2,
            "wexpr2": wexpr2,
            "wexpand": wexpr2.expand(),
            "fans": (m*x-n)*(x-p)
        }