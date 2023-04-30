class Generator(BaseGenerator):
    def data(self):    
        names =['Abigail','Brian','Carlos','Desiree','Ethan','Federico','Grant','Hailey','Indira','Jillian','Kai','Lucas','Maria','Natasha','Owen','Piero','Quinn','Riley','Santiago','Tucker','Ursula','Vincent','Werner','Xaviera','Yadier','Zaya']
        pronouns = ['she','he','he','she','he','he','he','she','she','she','they','he','she','she','he','he','they','she','he','they','she','she','he','she','she','they']
        i = randrange(0,26)

        while True:
            a = randrange(2,7)
            b = randrange(2,4)
            c = randrange(1,8)*choice([-1,1])
            m = randrange(1,6)
            n = choice([-1,1])*m / (m+randrange(1,4))
            d = a - b*(n-c)
            sgns = ['\\leq','<','>','\\geq'] # leq, le, geq, ge
            j = randrange(0,4)
            sign = sgns[j]
            oppsign = sgns[3-j]
            if( a != b ):
                break
        ssgn = ''
        if(c < 0):
            ssgn = '-'
        if(c > 0):
            ssgn = '+'
        vars = ['a','b', 'c', 'h', 'j', 'k', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'w', 'x', 'y', 'z']
        k = randrange(0,18)

        expr = a - b*(x-c)

        sops = [sign, oppsign]
        intops = [
            '(-\\infty,'+str(n)+']',
            '(-\\infty,'+str(n)+')',
            '('+str(n)+',-\\infty)',
            '['+str(n)+',-\\infty)',
            '(\\infty,'+str(n)+']',
            '(\\infty,'+str(n)+')',
            '('+str(n)+',\\infty)',        
            '['+str(n)+',\\infty)'
        ]
        if(j==0):
            corrint = 7 # [n,inf)
        if(j==1):
            corrint = 6 # (n,inf)
        if(j==2):
            corrint = 1 # (-inf,n)
        if(j==3):
            corrint = 0 # (-inf,n]
        while True:
            p = randrange(0,2)
            q = randrange(0,8)
            if(not( p==1 and q == corrint)):
                break

        icor = '' # assessment of inequality
        intcor = '' # assessment of interval
        if( p == 0 ): # inequality was incorrect
            icor = 'incorrect. Probably '+pronouns[i]+' did not reverse the inequality when dividing by -'+str(b)+' in the final step'
        if( p == 1 ):
            icor = 'correct'
        if( q==corrint ):
            intcor = 'correct.'
        if( q!= corrint ):
            intcor = 'incorrect. '
            if((corrint <=1 and q >= 4) or (corrint >=6 and q <= 3)): #wrong infinity
                intcor += 'The presence of the opposite infinity suggests '+pronouns[i]+' may have gotten the inequality backward along the way. '
            if(q>=2 and q<=5): #backward
                intcor += 'The chosen infinity is written on the wrong end of the interval notation. '
            if((corrint == 0 or corrint == 7) and (q==1 or q==2 or q==5 or q==6)): #used parentheses instead of brackets
                intcor += names[i]+' has also used parentheses next to '+str(n)+' when a bracket, meaning "include this value", was appropriate instead. '
            if((corrint == 1 or corrint == 6) and (q==0 or q==3 or q==4 or q==7)): #used brackets instead of paren
                intcor += names[i]+' has also used a bracket next to '+str(n)+' when a parenthesis, meaning "do not include this value", was appropriate instead. '
        dier = ''
        circle = ''
        if(oppsign == '\\leq'):
            dier = 'left'
            circle = 'a closed circle'
        if(oppsign == '<'):
            dier = 'left'
            circle = 'an open circle'
        if(oppsign == '>'):
            dier = 'right'
            circle = 'an open circle'
        if(oppsign == '\\geq'):
            dier = 'right'
            circle = 'a closed circle'

        return {
            "stu": names[i],
            "pn": pronouns[i],
            "expr": expr,
            "sign": sign,
            "oppsign": oppsign,
            "rhs" : d,
            "boundary": n,
            "j": j,
            "a": a,
            "b": b,
            "c": abs(c),
            "var": vars[k],
            "ssgn": ssgn,
            "asign": sops[p],
            "aint": intops[q],
            "corrint": intops[corrint],
            "icor": icor,
            "intcor": intcor,
            "dir": dier,
            "circle": circle,
            "t": n,
            "xmin": 3*abs(n),
            "endpt": 3*abs(n) if dier == 'right' else -3*abs(n),
            "ccolor": 'white' if circle == 'an open circle' else 'blue'
        }

    ## PROVIDE t , endpt , xmin
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "numline": arrow((data['t'],0),(data['endpt'],0),thickness=9, axes=True,ticks=[[0,data['t']],[]], xmin=-1*data['xmin'],xmax=data['xmin'],ymin=-0.05*data['xmin'], ymax=0.05*data['xmin'],aspect_ratio=1)+point2d([(data['t'],0)],size=48,color=data['ccolor'],markeredgecolor='blue')
            }