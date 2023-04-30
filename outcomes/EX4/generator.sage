class Generator(BaseGenerator):
    def data(self):
        var('x y t')
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
            b = QQ(randint(d+1,5*d)/d) # Base
            A = d*randint(2,20) / ( b^min(xs) ) # Intercept
        
        f(x) = A * b^x
        g(x) = A*exp(N(ln(b),digits=4)*x)
        
        ys = [f(i) for i in xs]        
        
        data = []
        for i in range(5):
            data.append({
                    'x': xs[i], 'y': ys[i]
                })
            
        ad1 = b
        
        while(ad1==b):
            ads = [2,3,4]
            multis = ["Double", "Triple", "Quadruple"]

            ii = randint(0,2)
            ad1 = ads[ii]
            multi = multis[ii]
        
        time1 = N(ln(ad1)/N(ln(b),digits=4),digits=4)
        
        ad2 = ad1
        while(ad2==ad1 or [ad1,ad2]==[2,4] or [ad1,ad2]==[4,2] or [ad1,ad2]==[2,8] or [ad1,ad2]==[3,9]):
            ads2 = [2,3,4,5,6,8,9,10]
            jj = randint(0,7)
            ad2 = ads2[jj]
            
        return{
            "f": g(t),
            "multiple": multi,
            "time1": time1,
            "data": data,
            "t1": ad1,
            "t2": ad2,
            "multiple2": ad2,
            "b1": ad1,
            "A": A,
            "mA": ad1*A,
            "lnb": N(ln(b),digits=4),
            "log12": N(log(ad2,ad1),digits=3),
            "log21": N(log(ad1,ad2),digits=3),
            "time2": N(log(ad2,ad1)*time1,digits=4),
            "time12": N(1/log(ad2,ad1)/time1,digits=4)
            
        }