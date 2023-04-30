class Generator(BaseGenerator):
    def data(self):
        var('x y')
        names =['Abigail','Brian','Carlos','Desiree','Ethan','Federico','Grant','Hailey','Indira','Jillian','Kai','Lucas','Maria','Natasha','Owen','Piero','Quinn','Riley','Santiago','Tucker','Ursula','Vincent','Werner','Xaviera','Yasmin','Zaya']
        pronouns =['she','he','he','she','he','he','he','she','she','she','they','he','she','she','he','he','they','she','he','they','she','he','he','she','she','they']
        possessives = ['her','his','his','her','his','his','his','her','her','her','their','his','her','her','his','his','their','her','his','their','her','his','his','her','her','their']
        ii = randrange(0,26)
        suffix = 's'
        if(pronouns[ii] == 'they'):
            suffix = ''
        majors = ['an art history', 'a music', 'an international relations', 'an English', 'a political philosophy', 'a psychology', 'a criminal justice', 'an anthropology', 'a history', 'a child development', 'a health science']
        shuffle(majors)
        
        ## Pick five x-values in 1..10, as long as not all are separated by 1
        xs = []
        c = 0
        k = 0 # Index of first in triplet
        j=choice([1,2])
        for i in [0,1,2]:
            if(c==0 and (i==2 or choice([True,False,0]))):
                m = choice([1,2])
                xs = xs + [j,j+m,j+2*m]
                k = xs.index(j)
                j = j + 2*m + choice([1,2])
                c = 1
            else:
                xs.append(j)
                j += choice([1,2])              
        b = 1    
        A = QQ(1/2)
        while(b == 1 or A.denominator() > 1 or (A*b^max(xs)).denominator() > 8):
            d = choice([1,2,3,4,5]) # Denominator of base
            b = QQ(randint(1,2*d)/d) # Base
            A = d*randint(2,20) / ( b^min(xs) ) # Intercept
        
        f(x) = A * b^x 
        
        ys = [f(i) for i in xs]
        ys[k+1] = (ys[k] + ys[k+2])/2 # The "wrong" y value
       
        
        
        data = []
        for i in range(5):
            data.append({
                    'x': xs[i], 'y': ys[i]
                })
            
            
            
        return {
            "stu": names[ii],
            "pn": pronouns[ii],
            "ppn": possessives[ii],
            "suf": suffix,
            "major": majors[0],
            "xs": xs,
            "data": data,
            "wrongx": xs[k+1],
            "wrongy": ys[k+1],
            "righty": f( xs[k+1] ),
            "f": f(x),
            "b": b,
            "k": k
        }