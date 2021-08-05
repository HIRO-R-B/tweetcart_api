#======== General Tests
#====
a.bc=[G]*3

a.sp<<[10,10,10,10,:p,0,255,0,0,255]
a.pr<<[20,10,10,10,0,255,0].solid
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

$c=[50,30,10,10,:p].sprite
a._pr<<$c
$c.x = 50 + $x
a._pr.clear if a._pr.length>50

$d||=[50,40,10,10]
a._bo<<$d if a.t<1
$d.x = 50 + $x

$e||=[50,50,'a']
a._la<<$e if a.t<1
$e.x = 50 + $x

$f||=[50,50,70,70]
a._li<<$f if a.t<1
$f.x = 50 + $x

a.la << [1280, 600, a.t, 0, 2]

m = a.m
a.s.rgb ||= [255, 0, 0]
if a.mw # mouse wheel
  y = a.mw.y
  if y > 0
    a.s.rgb.ro!
  else
    a.s.rgb = [255.r, 255.r, 255.r]
  end
end

a.sp<<[50,60,10,10,:p]
$circle||=[60,60,100,100,:c,0,255,255,0,255]
a._sp<<$circle if a.t<1
if a.mc
  $circle.w=r=300*rand
  $circle.h=r
  $circle.x=a.m.x-r/2
  $circle.y=a.m.y-r/2
  $circle[7]=255*rand
  $circle[8]=255*rand
  $circle[9]=255*rand
end
#====
