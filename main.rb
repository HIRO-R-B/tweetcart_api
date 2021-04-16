require 'app/tweetcart.rb'
require 'app/tweetcart_docs.rb'

$gtk.reset
def tick args
  if Kernel.global_tick_count == 0
    Kernel.export_docs!
    GTK::Tweetcart.setup args
  end
  t args
end

def t a
  a.bg=[127]*3

  a.sp<<[10,10,10,10,'sprites/square/blue.png']
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

  if a.m.br # While button right
    a.s.rgb.m! &:add[5]
    a.s.rgb.m! &:cw[0,255]
  end

  a.o.pe.sp << [m.x - 5, m.y - 5, 10, 10, :p, 0, 255, a.s.rgb]
  a.pec if a.m.c && a.m.bl # clear persistence on left click

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