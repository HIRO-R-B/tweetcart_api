# coding: utf-8
# MIT License
# tweetcart_docs.rb has been released under MIT (*only this file*).

# Contributors outside of DragonRuby who also hold Copyright:
# - https://github.com/HIRO-R-B
# - https://github.com/oeloeloel
# - https://github.com/leviongit

module TweetcartDocs
  def self.format_aliases aliases
    en      = aliases.each_slice(2)
    max_len = en.map { |new, _| new.length }.max
    out     = en.map { |new, old| "  #{new.to_s.ljust(max_len)} | #{old}" }.join("\n")

    <<-S
**** Aliases
#+begin_src
#{out}
#+end_src

S
  end

  def docs_method_sort_order
    [
      :docs_class,
      :docs_built_in_render_targets,
      :docs_math,
      :docs_summary,
      :docs_args,
      :docs_numeric,
      :docs_object
    ]
  end

  def docs_class
    <<-S
* DOCS: ~GTK::Tweetcart~
~GTK::Tweetcart~ provides short aliases for 'code golf' (making code as short as possible for fun) and creating Tweetcarts (a short program, game or artwork written in 280 characters or less and tweeted).\n
To make Tweetcart mode available, define your ~tick~ method as ~t~
#+begin_src
  def t a
    m = a.i_m                   # args.inputs.mouse
    a.sol << [m.x, m.y, 10, 10] # args.outputs.solids
  end
#+end_src

S
  end

  def docs_built_in_render_targets
    <<-S
** Built-In Render Targets
~GTK::Tweetcart~ provides built-in circle and 1x1 pixel render targets, which you can access with ~:c~ and ~:p~ respectively.
#+begin_src
  def tick a
    a.bc = [0, 0, 0] # a.outputs.background_color = [0, 0, 0]

    a.s.r ||= 0 # args.state.r ||= 0
    a.s.r += 1

    a.spr << [640 - 50, 360 - 50, 100, 100, :p, a.s.r] # args.outputs.sprites
    # Display a white rotating square in the middle of the screen

    m = a.m # a.inputs.mouse
    a.spr << [m.x - 50, m.y - 50, 100, 100, :c]
    # Display a white circle that follows your mouse cursor
  end
#+end_src
S
  end

  def docs_math
    <<-S
** Math
All methods available to ~Math~ are included into ~main~ and are usable
#+begin_src
  def tick a
    puts sin(a.t) # Math.sin(args.tick_count)
  end
#+end_src

S
  end

  def docs_summary
    <<-S
** Summary
*** main

**** CONSTANTS
#+begin_src
  F   | 255
  G   | 127
  W   | args.grid.w
  H   | args.grid.h
  N   | [nil]
  Z   | [0]
  PI  | Math::PI
  E   | Math::E
#+end_src

**** Methods
**** ~#CI x, y, radius, r = 0, g = 0, b = 0, a = 255~
Returns a circle sprite (as array) with a given ~radius~ that is centered at ~x~ and ~y~

S
  end

  def docs_args
    <<-S
*** args
#{TweetcartDocs.format_aliases GTK::Args::Tweetcart.aliases}

S
  end

  def docs_numeric
    <<-S
*** Numeric
**** Methods
#+begin_src
  sin
  cos
#+end_src

S
  end

  def docs_object
    <<-S
*** Object

**** ~#(SO! | SP! | PR! | LA! | LI! | BO!) *opts~
Aliases for pushing into outputs
#+begin_src
  def tick a
    SO! [0, 0, 10, 10], [100, 100, 200, 200]
    # a.so << [[0, 0, 10, 10], [100, 100, 200, 200]]
  end
#+end_src

**** ~#(_SO! | _SP! | _PR! | _LA! | _LI! | _BO!) *opts~
Static outputs variants

S
  end
end

module GTK::Tweetcart
  extend Docs
  extend TweetcartDocs
end

