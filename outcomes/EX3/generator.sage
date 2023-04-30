class Generator(BaseGenerator):
    def data(self):
        var('x y')
        
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
        
        k = randint(1,5)*choice([-1,1])
        
        f(x) = A * b^x + k
        
        ys = [f(i) for i in xs]
        
        data = []
        for i in range(5):
            data.append({
                    'x': ys[i], 'y': xs[i]
                })
        
        if (A>0):
            logf = r"\log_{"+str(b)+r"} \bigl( "+str(x-k)+r"\bigr) - \log_{"+str(b)+r"} "+str(A)
        else:
            logf = r"\log_{"+str(b)+r"} \bigl( "+str(k-x)+r"\bigr) - \log_{"+str(b)+r"} "+str(abs(A))
            
        return{
            "data": data,
            "fy": f(y),
            "logf": logf,
            "domain": r"(-\infty,"+str(k)+r")" if A < 0 else r"("+str(k)+r",\infty )" 
            
        }