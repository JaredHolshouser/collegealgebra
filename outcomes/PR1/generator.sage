class Generator(BaseGenerator):
    def data(self):
        while True:
            # Pick vertex, not on y-axis
            [h,k] = [randrange(1,8)*choice([-1,1]), randrange(-8,8)]
            # Pick leading coefficient, not +1
            A = QQ(choice([-4,-3,-2,-1,-1/2,-1/4,1/4,1/3,1/2,2,3/2,3,4]))
            if( abs(h) != abs(k) ):
                break
        # Pick second point
        s = choice([-1,1])
        [x0,y0] = [h+s*A.denominator(), k+A*A.denominator()^2]
        var('x')
        expr = A*(x-h)^2+k

        [fx,fy] = [h,k+1/4/A]
        dy = k - 1/4/A

        ggb = "P("+str(h)+","+str(k)+");Q("+str(x0)+","+str(y0)+");Text(("+str(h)+","+str(k)+"),P);Text(("+str(x0)+","+str(y0)+"),Q);Parabola(("+str(fx)+","+str(fy)+"),y="+str(dy)+");"

        return {
            "expr": expr,
            "sexpr": expr.full_simplify(),
            "h": h,
            "k": k,
            "x0": x0,
            "y0": y0,
            "fx": fx,
            "fy": fy,
            "dy": dy,
            "ggb": ggb,
            "q0": expr.subs({x: x0}),
            "xmin": 1.25*max(abs(k) for k in [h,k,x0,y0])
        }
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "parabola": plot(data['expr'],(x,-1*data['xmin'],data['xmin']),ymin=-1*data['xmin'],ymax=data['xmin']) + point([(data['h'],data['k']),(data['x0'],data['y0'])], size=48,color='black') + text("$P(%s,%s)$"%(data['h'],data['k']),(data['h'],data['k']),vertical_alignment='top',horizontal_alignment='left',color='black') + text("$Q(%s,%s)$"%(data['x0'],data['y0']),(data['x0'],data['y0']),vertical_alignment='top',horizontal_alignment='left',color='black') 
            }