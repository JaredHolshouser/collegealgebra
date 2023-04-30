class Generator(BaseGenerator):
    def data(self):
        var('x y')
        exprs = [abs(x), x^4, sqrt(x), sign(x)*(abs(x))^(1/3)]
        exprt = [r"|x|", r"x^4", r"\sqrt{x}", r"\sqrt[3]{x}"]
        i=randint(0,3)
        p(x) = exprs[i],
        exprtext = exprt[i]
        
        [A,B,C,D] = [1,1,0,0]
        s = choice([0,1,2,3]) # Which transformation to skip
                
        steps = []
        
        if(s!=0):
            A = choice([-3,-2,-1,2,3,4,QQ(-1/2), QQ(1/2)])
            vr = "reflection and " if A < 0 else ""
            steps.append({"step": "vertical "+vr+"stretch by a factor of "+str(abs(A))})
        if(s!=1):
            B = choice([-3,-2,-1,2,3,4,QQ(-1/2), QQ(1/2)])
            hr = "reflection and " if B < 0 else ""
            steps.append({"step": "horizontal "+hr+"shrink by a factor of "+str(abs(B))})
        if(s!=2):
            C = randint(1,4)*choice([-1,1])
            hd = "left" if C < 0 else "right"
            steps.append({"step": "horizontal shift "+hd+" by "+str(C)+" units"})
        if(s!=3):
            D = randint(1,4)*choice([-1,1])
            vd = "up" if D > 0 else "down"
            steps.append({"step": "vertical shift "+vd+" by "+str(D)+" units"})
        
        P = vector([C,D])
        Q = vector([1/B+C,A+D])
        
        f(x) = A*p( B*(x-C) ) + D
        texprtext = f(x)

        
        
        
        return {
            "parent": p(x),
            "expr": exprtext,
            "transf": f(x),
            "texpr": f(x),
            "P": P,
            "Q": Q,
            "Px": P[0],
            "Py": P[1],
            "Qx": Q[0],
            "Qy": Q[1],
            "steps": steps
        }
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "parent": plot(data['parent'],(x,-3,3),xmin=-3,xmax=3,axes_labels=[r"$x$", "$y="+data['expr']+"$"])+point([(0,0)],size=48, color='black')+point([(1,1)],size=48,color='orange')+text('(0,0)',(0,0),color='black', horizontal_alignment='left')+text('(1,1)',(1,1),color='orange', horizontal_alignment='left'),"transform": plot(data['transf'],(x,-6,6),xmin=-6,xmax=6,axes_labels=[r"$x$", "$y=?$"])+point(data['P'],size=48, color='black')+point(data['Q'],size=48,color='orange')+text(str(data['P']),data['P'],color='black', horizontal_alignment='left')+text(str(data['Q']),data['Q'],color='orange', horizontal_alignment='left')
            
            }