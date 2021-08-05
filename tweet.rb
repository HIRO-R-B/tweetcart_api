#======== General Tests
#====
a.bc=[G]*3

a.spr<<[10,10,10,10,:p,0,255,0,0,255]
a.pri<<[20,10,10,10,0,255,0].solid
a.bor<<[30,10,10,10,255,255,255]

puts "space!" if a.k_d.space
puts "left" if a.l
puts "right" if a.r
puts "up" if a.u
puts "down" if a.d

m = a.m
a.s.rgb ||= [255, 0, 0]
if a.m_w # mouse wheel
  y = a.m_w.y
  if y > 0
    a.s.rgb.rotate!
  else
    a.s.rgb = [255*rand, 255*rand, 255*rand]
  end
end

a.s.b ||= 0
a.s.b += 1
a.s.b %= 360
a.spr<<[100,100,100,100,:p,a.s.b,255,a.s.rgb]

$x += 2
$x %= 800

  $a||=[50,10,10,10]
a._sol<<$a if a.t<1
$a.x = 50 + $x

$b||=[50,20,10,10,:p]
a._spr<<$b if a.t<1
$b.x = 50 + $x

$c=[50,30,10,10,:p].sprite
a._pri<<$c
$c.x = 50 + $x
a._pri.clear if a._pri.length>50

$d||=[50,40,10,10]
a._bor<<$d if a.t<1
$d.x = 50 + $x

$e||=[50,50,'a']
a._lab<<$e if a.t<1
$e.x = 50 + $x

$f||=[50,50,70,70]
a._lin<<$f if a.t<1
$f.x = 50 + $x

a.lab << [1280, 600, a.t, 0, 2]

a.spr<<[50,60,10,10,:p]
$circle||=[60,60,100,100,:c,0,255,255,0,255]
a._spr<<$circle if a.t<1
if a.m_c
  $circle.w=r=300*rand
  $circle.h=r
  $circle.x=a.m.x-r/2
  $circle.y=a.m.y-r/2
  $circle[7]=255*rand
  $circle[8]=255*rand
  $circle[9]=255*rand
end
#====
