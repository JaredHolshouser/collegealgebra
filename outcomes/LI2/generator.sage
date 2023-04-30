class Generator(BaseGenerator):
    def data(self):
        var('x y')
        w = choice(['x','y'])
        while True:
            [A,B] = [randrange(1,8)*choice([-1,1]), randrange(2,8)*choice([-1,1])]
            if( abs(A)!=abs(B) ):
                break
        m = -A/B
        mperp = B/A

        while True:
            [px, py] = [randrange(2,8)*choice([-1,1]), randrange(2,8)*choice([-1,1])]
            [qx, qy] = [randrange(2,8)*choice([-1,1]), randrange(2,8)*choice([-1,1])]
            if( A*(py-qy) != B*(qx-px) ):
                break
        
        yo = (A*qx+B*qy)/B # y-coord for label on original line
        theta = arctan(-A/B)*180/3.14159265 # rotate label


        return {
            "w" : w,  # which intercept to find
            "px": px, 
            "py": py,  # point through which line passes
            "lhs": A*x + B*y,
            "rhs": A*qx + B*qy,
            "lhs1": A*x + B*y,
            "origline": str(A*x + B*y)+"="+str(A*qx + B*qy),
            "rhs1": A*px+B*py,
            "x1": px+B/A*py,
            "y1": A/B*px + py,
            "lhs2": B*x - A*y,
            "rhs2": B*px - A*py,
            "x2": px - A/B*py,
            "y2": py - B/A*px,
            "rhs11": m*x + py - m*px,
            "rhs22": mperp*x + py - mperp*px,
            "yo": yo,
            "theta": theta,
            "A": A,
            "AB": abs(B),
            "op": "+" if B > 0 else "-"
        }
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "graph1": implicit_plot(data['lhs']-data['rhs'],(x,-15,15),(y,-15,15),color='gray', thickness=0.5)+point([(data['px'],data['py'])],size=48)+plot(data['rhs11'],(x,-15,15),ymin=-15,ymax=15)+text("$P(%s,%s)$"%(data['px'],data['py']),(data['px'],data['py']),horizontal_alignment='left',vertical_alignment='top')+text("$%s x %s %s y = %s$"%(data['A'],data['op'],data['AB'],data['rhs']),(0,data['yo']),vertical_alignment='top',color='gray',rotation=data['theta']),
            "graph2": implicit_plot(data['lhs']-data['rhs'],(x,-15,15),(y,-15,15),color='gray', thickness=0.5)+point([(data['px'],data['py'])],size=48)+plot(data['rhs22'],(x,-15,15),ymin=-15,ymax=15)+text("$P(%s,%s)$"%(data['px'],data['py']),(data['px'],data['py']),horizontal_alignment='left',vertical_alignment='top')+text("$%s x %s %s y = %s$"%(data['A'],data['op'],data['AB'],data['rhs']),(0,data['yo']),vertical_alignment='top',color='gray',rotation=data['theta'])
            }