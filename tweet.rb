
=begin
def t a
  a.bg=[127]*3

  a.sp<<[10,10,10,10,:p,0,255,0,0,255]
  a.pr<<[20,10,10,10,0,255,0].so
  a.bo<<[30,10,10,10,255,255,255]

  puts "space!" if a.kd.space
  puts "left" if a.l
  puts "right" if a.r
  puts "up" if a.u
  puts "down" if a.d

  a.s.b ||= 0
  a.s.b += 1
  a.s.b %= 360
  a.sp<<[100,100,100,100,:p,a.s.b,255,255,0,0]

  $x += 2
  $x %= 800

  $a||=[50,10,10,10]
  a._so<<$a if a.t<1
  $a.x = 50 + $x

  $b||=[50,20,10,10,:p]
  a._sp<<$b if a.t<1
  $b.x = 50 + $x

  $c=[50,30,10,10,:p].sp
  a._pr<<$c
  $c.x = 50 + $x
  a._pr.c if a._pr.l>50

  $d||=[50,40,10,10]
  a._bo<<$d if a.t<1
  $d.x = 50 + $x

  $e||=[50,50,'a']
  a._la<<$e if a.t<1
  $e.x = 50 + $x

  $f||=[50,50,70,70]
  a._li<<$f if a.t<1
  $f.x = 50 + $x

  a.o.la << [1280, 720, a.t, 0, 2]
  a.la << [ # key state testing
            "kd: #{a.kd.tk}",
            "kh: #{a.kh.tk}",
            "ku: #{a.i.k.ku.tk}",
            "#text: #{a.it}"
  ].mwi { |s, i| [0, 720 - i * 22, s] }

  m = a.i.m
  a.s.rgb ||= [255, 0, 0]
  if a.mw # mouse wheel
    y = a.mw.y
    if y > 0
      a.s.rgb.ro!
    else
      a.s.rgb = [255.r, 255.r, 255.r]
    end
  end

  if a.m.r # While button right
    a.s.rgb.m! &:add[5]
    a.s.rgb.m! &:cw[0,255]
  end

  a.o.p.sp << [m.x - 5, m.y - 5, 10, 10, :p, 0, 255, a.s.rgb]
  a.pc if a.m.c && a.m.l # clear persistence on left click

  a.sp<<[50,60,10,10,:p]
  $circle||=[60,60,100,100,:c,0,255,255,0,255]
  a._sp<<$circle if a.t<1
  if a.mc
    $circle.w=r=300.r
    $circle.h=r
    $circle.x=a.m.x-r/2
    $circle.y=a.m.y-r/2
    $circle[7]=255.r
    $circle[8]=255.r
    $circle[9]=255.r
  end
end
=end

# def t a;A||=a.o[S=:b].sp<<[F=79,F,P=140,P,:c,0,D=410,[F]*3];a.sp<<[[320,B=[G=200,20,G,S],97],[440,B,-F],[H=360,P,4*H,720,S],[345,220,896,504,S],[H,300,V=[256,H,S,15]],[D,310,V],[D,G,V],[450,175,V],[570,135,V[0,3],-15],P.t.m{|i|[550,345,atan(Z=a.t.d(5))*i,Z.sin*i,S,a.t.cos*i]}]end

# i=:to_i[];s=i>>:sin[];c=i>>:cos[];f.draw_sprite_3 x=@x+=s[@y*4],y=@y+=c[x*4],w=(s[y]*c[x]*10).a+8,w,'c',0,F,(x-F)*b=0.8,(y-99)*b,(x+y-H)*b,*[p]*12

# class S;attr :x,:y;def draw_override f
# f.draw_sprite_3 x=@x+=(@y*4).to_i.sin,y=@y+=(x*4).to_i.cos,w=(y.to_i.sin*x.to_i.cos*10).a+8,w,'c',0,F,(x-F)*b=0.8,(y-99)*b,(x+y-H)*b,*[p]*12
# end;end

# f.draw_sprite_3 self.x+=(y*4).to_i.sin,self.y+=(x*4).to_i.cos,w=(x.to_i.sin*y.to_i.cos*10).a+8,w,'c',0,F,(x-F)*b=0.8,(y-99)*b,(x+y-H)*b,*[p]*12

# S=Struct.new:x,:y{def draw_override f
# f.draw_sprite_3 self.x+=(i=:to_i[])[y*4].sin,self.y+=i[x*4].cos,w=(i[x].sin*i[y].cos*10).a+8,w,'c',0,F,(x-F)*b=0.8,(y-99)*b,(x+y-H)*b,*[p]*12
# end}
# def t a
# (_SP!.c;PC!)if a.mr
# b=S.new(*a.m.p)if a.ml
# a.kh.z ? PSP!(b):_SP!(b)
# PSP!
# end

# (b=S.new).x,b.y=a.m.p if a.ml




#================ Implicit Tick Tests Below
#====
# $t+=2
# PSP! [0,0,W,H,:p,0,V=40,0,0,0],32.mwy(18){|x,y|[V*x,20*y+V*($t+x*V).sin-V,V,V,:p,$t,F,c=(V*x+$t).cw(0,F),2*c,3*c]}
#====

#======== P Class Tests
#====

# # T ||= Class.new do attr_sprite; def draw_override f; f.draw_sprite_3 x=@x+=(@y*4).to_i.sin,y=@y+=(x*4).to_i.cos,w=(y.to_i.sin*x.to_i.cos*10).a+8,w,'c',0,F,(x-F)*b=0.8,(y-99)*b,(x+y-H)*b,*[p]*12; end; end
# # T||=Class.new do attr_sprite;def draw_override f;f.draw_sprite_3 x=@x+=(@y*4).sin,y=@y+=(x*4).cos,w=(y.sin*x.cos*10).a+8,w,'c',0,F,(x-F)*b=0.8,(y-99)*b,(x+y-H)*b,*[p]*12;end;end
# # T||=P.do(:x,:y){|f|f.draw_sprite_3 x=@x+=(@y*4).sin,y=@y+=(x*4).cos,w=(y.sin*x.cos*10).a+8,w,'c',0,F,(x-F)*b=0.8,(y-99)*b,(x+y-H)*b,*[p]*12}
# T||=P.sp{|f|f.dsp x=@x+=(@y*4).sin,y=@y+=(x*4).cos,w=(y.sin*x.cos*10).a+8,w,'c',0,F,(x-F)*b=0.8,(y-99)*b,(x+y-H)*b}
# a.mr&&(_SP!.c;PC!)
# (b=T.new;b.x=a.m.x;b.y=a.m.y)if a.ml
# a.kh.z ? (PSP! b):(_SP! b)
# PSP!
# a.o.de << $gtk.current_framerate_primitives
#====

#====

# a.bg=[0,0,0]
# x=a.m.x>W/2? W : 0;y=a.m.y>H/2? H : 0
# T||=P.dsp(:c){@w+=a.t.sin;@h+=a.t.cos}
# _SP! T.new(*a.m.p) if a.ml
# a.vp *600.ts(W/2,H/2),*[F]*3

# T||=P.dli{@x+=a.t.sin;@y+=a.t.cos}
# _SP! T.new(*a.m.p, x, y, 255) if a.ml
# _PR! T.new(*a.m.p, y2: y, x2: x, b: 255) if a.mr

# T||=P.li{|f|f.dli @x+=a.t.sin,@y+=a.t.cos,@x2,@y2,@r,@g,@b}
# _SP! T.new(x: a.m.x, y: a.m.y, x2: x, y2: y, r: 255) if a.ml
# if a.mr
  # p = T.new(x: a.m.x, x2: x, b: 255)
  # p.y = a.m.y
  # p.y2 = y
  # _PR! p
# end
#====
#========

#==== Saturn with Moons

# I||=_SP! CI 5+A=W/2,5+B=H/2,95
# a.bg=Z*3
# t=a.t
# srand 0
# 82.t{|i|a,b=t.v
# PSP! ar=[A+50*(2*b+i*a),B+50*(2*a+i*b),C=[10,10,:p],t]if i<9
# t<270&&i<3&&_SP!(ar)
# v=W.r+t*0.2.rr
# a,b=v.v
# PR! [d=[A+10*(50*b+i*a),B+10*(50*a+i*b)],C,v,d.p.pic?([A,B],100)&&v%B>180&&0].sp}
#====

#==== Poly Test using Akziden's Line Thing

# a.bg=Z*3
# # Original:
# # 360.t{|h|LI! [640+h.sin*300,360+h.cos*300,640+cos(h*$a+=1e-06)*150,360+sin(h*$a)*150,F,F,F]}
# # With PLY:
# LI! PLY 0.st(360,2).m{|h|[640+h.sin*300,360+h.cos*300,640+cos(h*$a+=1e-06)*150,360+sin(h*$a)*150]},F,F,F
#====

#======== Triangle Tests
#==== Equilateral Triangle
# I||=(D=T=2
# C=->n{F.h.+n.vx F.h}
# G=->d,x,y,s,a{d>1?3.t.m{|i|(a+i*120).v(s*S60/3+s/4*T.sin).str(x,y)}.mwi{|p,i|G[d-1,p.x,p.y,s/2,a+i*a]}: TR(x,y,s,a,C[a],C[a+90],C[a/6])})
# T+=0.05*D
# a.bg=Z*3
# D=(1+a.my/H*5).fl
# PSP! G[D,640,360,H,T]
#====

#==== Right Triangle
b = 640 + a.t.vx(640)
h = 360 + a.t.vy(360)
SP! [0,0,b,h,:tr,0,F,0,0,0]
$gtk.slowmo! 4

#====
