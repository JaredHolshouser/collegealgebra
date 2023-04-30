class Generator(BaseGenerator):
    def data(self):
        import re

        while True:
            #Select five distinct potential roots
            r = [randrange(-6,6),randrange(-6,6),randrange(-6,6),randrange(-6,6),randrange(-6,6)]
            r.sort()
            if( len(r)==len(set(r)) ):
                break

        #At most two double roots
        m = [1,1,1,1,1]
        while True:
            [i,j]=[randrange(0,4),randrange(0,4)]
            if(i!=j):
                m[i] += 1
                m[j] += 1
                break

        #Choose 3, 4, or 5 factors at random and build a dict of them
        while True:
            [a,b] = [randrange(0,4), randrange(0,4)]
            if(a!=b):
                break

        numroots = choice([3,4,5])
        ro = [] # Actual roots
        x = var('x')
        facs = []
        for k in range(0,5):
            if(numroots == 3):
                if(k==a or k==b):
                    continue
            if(numroots == 4):
                if( k==a ):
                    continue
            facs.append({'factor': x - r[k], 'exponent': m[k]})
            ro.append(r[k])

        lc = choice([-1,1])
        cm = lc
        cd = lc
        #Find which pair of roots x=0 is between & set t accordingly
        
        if product(ro) == 0: #Use even faketicks
            t = -2-2*len([i for i in ro if i < 0])
        else: #Use odd faketicks
            t = -1-2*len([i for i in ro if i < 0])
            
        
        # t = -3 
        ggbtext = ""
        rused = []
        rud = []
        faketicks = []
        facstext = []
        lppoints = []
        degree = 0
        for fac in facs:
            cm *= fac['factor']^fac['exponent']
            cd *= (x-t)^fac['exponent']
            ggbtext += "Text(\""+str(-1*fac['factor'].subs({x:0}))+"\",("+str(N(t-0.1,digits=3))+",-0.3));"
            t += 2
            degree += fac['exponent']
            rused.append(-1*fac['factor'].subs({x:0}))
            rud.append({'r':-1*fac['factor'].subs({x:0})})
            if(fac['exponent'] > 1):
                facstext.append({'factor':fac['factor'],'exponent':fac['exponent']})
                lppoints = lppoints + [[t-0.1,0],[t+0.1,0]]
                faketicks.append(t)
            else:
                facstext.append({'factor':fac['factor'],'exponent':''})
                lppoints.append([t,0])
                faketicks.append(t)
        re = 0.1 if lc > 0 else -0.1
        le = 0.1 if (lc > 0 and Mod(degree,2)==0) or (lc < 0 and Mod(degree,2)==1) else -0.1
        lppoints = lppoints + [[min(faketicks)-1,le],[max(faketicks)+1,re]]



        # cmc = re.sub(r'\^',r'**',re.sub(r'\+',r'--',re.sub(r'\s+','',str(cd.full_simplify()))))
        cmc = ''
        
        # Figure out where to draw the y-axis
        xx = 0
        n = len(rused)
        if(rused[0]>0): # All roots positive
            xx = -5
        if(xx == 0): # Some of each
            xx = -3
            for k in range(0,n):
                if(rused[k] == 0):
                    break
                if(rused[k]<0 and k==n-1):
                    xx += 2
                    break
                if(rused[k]*rused[k+1]<0): # Found the sign change
                    xx += 2*rused[k]/(rused[k]-rused[k+1])
                    break
                xx += 2


        ggb = "y="+cmc+";y=0;x="+str(xx)+";"+ggbtext

        sign = '-'
        if(lc > 0):
            sign = ''

            
        R.<x> = PolynomialRing(QQ)
        flag = R.lagrange_polynomial(lppoints)
            
        return {
            "ggb": ggb,
            "expr": cm,
            "r": rused,
            "ggbtext": ggbtext,
            "lc": lc,
            "deg": degree,
            "sign": sign,
            "facs": facstext,
            "roots": rud,
            "lctext": "positive" if lc > 0 else "negative",
            "lcexplain": "increases to infinity" if lc > 0 else "decreases to negative infinity",
            "parity": "even" if Mod(degree,2)==0 else "odd",
            "rend": r"\infty" if lc > 0 else r"-\infty",
            "lend": r"\infty" if (lc > 0 and Mod(degree,2)==0) or (lc < 0 and Mod(degree,2)==1) else r"-\infty",
            "match": "match" if Mod(degree,2)==0 else "do not match",
            "matchtwo": "the same-signed" if Mod(degree,2)==0 else "opposite-signed",
            "xmin": min(faketicks)-1,
            "xmax": max(faketicks)+1,
            "xticks": rused,
            "cd": cd,
            "lpp": flag,
            "faketicks": faketicks
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "polynomial": plot(data['lpp'](x),(x,data['xmin'],data['xmax']),axes=[True,False],ticks=[data['faketicks'],[]],tick_formatter=[data['xticks'],0],zorder=20,ymin=-0.1,ymax=0.1)
            }
    