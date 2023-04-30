class Generator(BaseGenerator):
    def data(self):
        names = ['Abigail','Brian','Carlos','Desiree','Ethan','Federico','Grant','Hailey','Indira','Jillian','Kai','Lucas','Maria','Natasha','Owen','Piero','Quinn','Riley','Santiago','Tucker','Ursula','Vincent','Werner','Xaviera','Yadier','Zaya']
        pronouns = ['she','he','he','she','he','he','he','she','she','she','they','he','she','she','he','he','they','she','he','they','she','he','he','she','she','they']
        pospronouns = ['her','his','his','her','his','his','his','her','her','her','their','his','her','her','his','his','their','her','his','they','her','her','his','her','her','their']

        k=randrange(0,26) # Select student name and pronouns
        
        [A,b,C,D] = [QQ(3/2),2,0,3]
        while(A.denominator()>1 or C == 0 or abs(A) == 1):
            D = randint(1,3)*choice([-1,1])
            C = randint(-2,3) - D
            b = choice([2,3,4,5,6,10])
            A = D/b^randint(-2,3)
        
        var('x')
        sop = '+' if C > 0 else '-'

        
        
        
        return {
            "stu": names[k],
            "pn": pronouns[k],
            "ppn": pospronouns[k],
            "lhs1": A*b^(x+C),
            "rhs1": D,
            "a1": A,
            "b1": b,
            "dda": QQ(D/A),
            "ldda": log(D/A,b),
            "exp1": x+C,
            "lhswrong1": (A*b)^(x+C),
            "rhswrong1": D,
            "lhswrong2": x,
            "rhswrong2": str(-1*C)+r"+\log_{"+str(A*b)+r"}"+str(D),
            "lhs2": r"\log_{"+str(b)+r"} \bigl("+str(A)+r"y\bigr)"+sop+str(abs(C)),
            "rhs2": D,
            "xsol": log(D/A, b) - C,
            "ysol": QQ((b^(D-C))/A),
            "suf": '' if pronouns[k] == 'they' else 's',
            "c1": C,
            "op": "-" if C > 0 else "+",
            "ac": abs(C),
            "dmc": D-C,
            "bdmc": b^(D-C)
        }
