require 'app/tweetcart.rb'

$gtk.reset
def tick args
  if Kernel.global_tick_count == 0
    GTK::Tweetcart.setup args
  end
  t args
end

def t a
  a.bg=[127]*3

  # a.os<<[99,99,1e3,1e3]
  a.osp<<[10,10,10,10,'sprites/square/blue.png']
  a.op<<[20,10,10,10,0,255,0].solid
  a.ol<<[10,40,"test"]
  a.ob<<[30,10,10,10,255,255,255]
  puts "!" if a.ikd.space
  # puts a.im.x
  puts "l" if a.il
  puts "r" if a.ir
  puts "u" if a.iu
  puts "d" if a.id
  # puts sin(1)

  a.osp<<[100,100,100,100,:p,255,255,255,0,0]
  a.s.b||=10
  a.s.b+=1
  $a||=[50,10,10,10]
  a.o_s<<$a if a.tc<1
  $a.x+=1
  $b||=[50,20,10,10,:p]
  a.o_sp<<$b if a.tc<1
  $b.x+=1
  $c||=[50,30,10,10,:p].sprite
  a.o_p<<$c #if a.tc<1
  $c.x+=1
  $d||=[50,40,10,10]
  a.o_b<<$d if a.tc<1
  $d.x+=1
  $e||=[50,50,'a']
  a.o_l<<$e if a.tc<1
  $e.x+=1
  $f||=[50,50,70,70]
  a.o_li<<$f if a.tc<1
  $f.x+=1

  a.o.l << [1280, 720, a.tc, 0, 2]
  a.ol  << [ # key state testing
    "kd: #{a.ikd.tk}",
    "kh: #{a.ik.kh.tk}",
    "ku: #{a.i.k.ku.tk}",
    "#text: #{a.i.t}"
  ].map_with_index { |s, i| [0, 720 - i*22, s] }
  # a.os << [a.imc.x, a.imc.y, 100, 100] if a.imc # mouse click
  a.os << [a.i.m.p.x, a.i.m.p.y, 20, 20, [a.im.w.y < 0 ? 255 : 0]*3] if a.im.w # mouse wheel

  a.osp<<[50,60,10,10,:p]
  $circle||=[60,60,100,100,:c,0,255,255,0,255]
  a.o_sp<<$circle if a.tc<1
  if a.imc
    $circle.w=r=rand(300)
    $circle.h=r
    $circle.x=a.im.x-r/2
    $circle.y=a.im.y-r/2
    $circle[7]=rand(255)
    $circle[8]=rand(255)
    $circle[9]=rand(255)
  end

  a.ops.s << [a.im.p.x, a.im.p.y, 5, 5] if a.im.m # mouse move, to persistence
  a.opsc if a.imc # clear persistence
end