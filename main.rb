require 'app/tweetcart.rb'

$gtk.reset
def tick args
  if Kernel.global_tick_count == 0
    args.class.include          ::GTK::Args::Tweetcart
    args.outputs.class.include  ::GTK::Outputs::Tweetcart
    args.inputs.class.include   ::GTK::Inputs::Tweetcart
    args.grid.class.include     ::GTK::Grid::Tweetcart
    args.geometry.include       ::GTK::Geometry::Tweetcart
    args.geometry.extend        ::GTK::Geometry::Tweetcart

    $top_level.include          ::GTK::Main::Tweetcart

    args.outputs[:p].w = 1
    args.outputs[:p].h = 1
    args.outputs[:p].solids << [0, 0, 1, 1, 255, 255, 255]
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
  if a.tick_count < 1
    a.outputs[:px].w = 1
    a.outputs[:px].h = 1
    a.outputs[:px].solids << [0, 0, 1, 1, 255, 255, 255]
  end

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
end
