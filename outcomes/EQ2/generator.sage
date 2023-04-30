class Generator(BaseGenerator):
    def data(self):
        vars = ['a','b','c','h','j','k','m','n','p','q','r','t','u','w','x','y','z']
        i = randrange(0,17)

        while True:
            a = randrange(2,8)
            b = randrange(1,9)*choice([-1,1])
            c = randrange(1,50)
            if( (abs(a)-abs(b))*(abs(b)-abs(c))*(abs(a)-abs(c)) != 0 and QQ(c/a).denominator() <= 2  ):
                break

        if(b>0):
            sgn = "+"
        if(b<0):
            sgn = "-"

        signs = ['\\leq', '<', '>', '\\geq']
        k = randrange(0,4)

        left = ''
        right = ''
        if(k==0 or k==3):
            left = '['
            right = ']'
        if(k==1 or k==2):
            left = '('
            right = ')'

        lend = QQ(-b-c/a)
        rend = QQ(-b+c/a)

        if(lend.denominator() == 2):
            lend = round(lend, ndigits=1)
            rend = round(rend, ndigits=1)

        origsol = ''
        if(k<=1): # bounded interval
            origsol = left+str(lend)+','+str(rend)+right
        if(k>=2): # complement of bounded interval
            origsol = '(-\\infty,'+str(lend)+right+' \\cup '+left+str(rend)+',\\infty)'

        change = randrange(0,4) # Change value of a, b, c, or sign
        kn = k # Is only changed if sign is altered
        if(change==0):
            while True:
                if( a==2 ):
                    an = 1
                    break
                an = randrange(2,8)
                if( an!=a and QQ(c/an).denominator() <= 2  ):
                    break
            bn = b
            cn = c
            sgnn = sgn
            ineqn = signs[k]
        if(change==1):
            while True:
                bn = randrange(1,12)*choice([-1,1])
                if( abs(bn)!= abs(b) ):
                    break
            an = a
            cn = c
            sgnn = ''
            if(bn > 0):
                sgnn = '+'
            if(bn < 0):
                sgnn = '-'
            ineqn = signs[k]
        if(change==2):
            while True:
                cn = randrange(1,50)
                if( abs(cn)!=abs(c) and QQ(cn/a).denominator() <= 2   ):
                    break
            an = a
            bn = b
            sgnn = sgn
            ineqn = signs[k]
        if(change==3):
            while True:
                kn = randrange(0,4)
                if(not ((k<=1 and kn<=1) or (k>=2 and kn>=2))): # Sense of inequality needs to reverse
                    break
            an = a
            bn = b
            cn = c
            sgnn = sgn
            ineqn = signs[kn]

        leftn = ''
        rightn = ''
        if(kn==0 or kn==3):
            leftn = '['
            rightn = ']'
        if(kn==1 or kn==2):
            leftn = '('
            rightn = ')'

        newsol = ''
        lendn = QQ(-bn-cn/an)
        rendn = QQ(-bn+cn/an)

        if(lendn.denominator() == 2):
            lendn = round(lendn, ndigits=1)
            rendn = round(rendn, ndigits=1)

        if(kn<=1): # bounded interval
            newsol = leftn+str(lendn)+','+str(rendn)+rightn
        if(kn>=2): # complement of bounded interval
            newsol = '(-\\infty,'+str(lendn)+rightn+' \\cup '+leftn+str(rendn)+',\\infty)'
        xmin = 3*max(abs(lendn),abs(rendn))
            
        return {
            "a": a,
            "var": vars[i],
            "sgn": sgn,
            "realb": abs(b),
            "b": abs(b),
            "ineq": signs[k],
            "c": c,
            "origsol": origsol,
            "newsol": newsol,
            "an": an,
            "sgnn": sgnn,
            "bn": abs(bn),
            "cn": cn,
            "ineqn": ineqn,
            "lend": lend,
            "rend": rend,
            "xmin": xmin,
            "lendn": lendn,
            "rendn": rendn,
            "int1l": -1*xmin if kn>=2 else lendn,
            "int1r": lendn if kn>=2 else rendn,
            "int2l": rendn if kn >= 2 else lendn,
            "int2r": xmin if kn >= 2 else rendn,
            "ccolor": 'white' if (kn==1 or kn==2) else 'blue'
        }
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "numline": line([(data['int1l'],0),(data['int1r'],0)],thickness=4, axes=True,ticks=[[0,data['lendn'],data['rendn']],[]], xmin=-1*data['xmin'],xmax=data['xmin'],ymin=-0.05*data['xmin'], ymax=0.05*data['xmin'],aspect_ratio=1)+line([(data['int2l'],0),(data['int2r'],0)],thickness=4, axes=True,ticks=[[0,data['lendn'],data['rendn']],[]], xmin=-1*data['xmin'],xmax=data['xmin'],ymin=-0.05*data['xmin'], ymax=0.05*data['xmin'],aspect_ratio=1)+point2d([(data['lendn'],0)],size=60,color=data['ccolor'],markeredgecolor='blue')+point2d([(data['rendn'],0)],size=60,color=data['ccolor'],markeredgecolor='blue')
            }