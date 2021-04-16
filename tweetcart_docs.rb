module TweetcartDocs
  def docs_method_sort_order
    [
      :docs_class,
      :docs_render_targets,
      :docs_persistent_outputs,
      :docs_alias_summary
    ]
  end

  def docs_class
    <<-S
* DOCS: ~GTK::Tweetcart~
~GTK::Tweetcart~ provides short aliases for creating Tweetcarts\n
To make them available, define your ~tick~ method as ~t~
#+begin_src
  def t a
    m = a.i.m                   # args.inputs.mouse
    a.o.s << [m.x, m.y, 10, 10] # args.outputs.solids
  end
#+end_src

S
  end

  def docs_render_targets
    <<-S
** Built-In Render Targets
~GTK::Tweetcart~ provides built-in circle and 1x1 pixel render targets, which you can access with ~:c~ and ~:p~ respectively.
#+begin_src
  def t a
    a.bg = [0, 0, 0] # a.outputs.background_color = [0, 0, 0]

    a.s.r ||= 0 # args.state.r ||= 0
    a.s.r += 1

    a.o.sp << [640 - 50, 360 - 50, 100, 100, :p, a.s.r] # args.outputs.sprites
    # Display a white rotating square in the middle of the screen

    m = a.i.m # a.inputs.mouse
    a.o.sp << [m.x - 50, m.y - 50, 100, 100, :c]
    # Display a white circle that follows your mouse cursor
  end
#+end_src
S
  end

  def docs_persistent_outputs
    <<-S
** Persistent Outputs
~GTK::Tweetcart~ provides a "persistent" outputs render target and whatever you draw with it persists to later frames.\n
You can access it using ~outputs.ps~ and clear it with ~outputs.psc~
#+begin_src
  def t a
    a.bg = [0, 0, 0]

    m = a.i.m
    a.o.ps.sp << [m.x - 25, m.y - 25, 50, 50, :p] # a.outputs.ps.sprites
    # Draws white squares to your mouse's location that persist to your screen

    a.o.psc if m.c # Clear Persistent Outputs if you click the mouse
  end
#+end_src
S
  end

  def self.format_aliases aliases
    max_length = aliases.each_slice(2).map { |new, _| new.length }.max
    out = aliases.each_slice(2).map { |new, old| "  #{new}#{' ' * (max_length - new.length)} | #{old}" }.join("\n")
    "#+begin_src\n#{out}\n#+end_src"
  end

  def self.extended(base)
    base.singleton_class.instance_eval <<-SRC
      define_method(:docs_alias_summary) do
        <<-S
** Alias Summary
*** args
#{ format_aliases GTK::Args::Tweetcart.aliases }
*** args.inputs
#{ format_aliases GTK::Inputs::Tweetcart.aliases }
**** *.mouse
#{ format_aliases GTK::Mouse::Tweetcart.aliases }
**** *.keyboard
#{ format_aliases GTK::Keyboard::Tweetcart.aliases }
*** args.outputs
#{ format_aliases GTK::Outputs::Tweetcart.aliases }
*** args.geometry
#{ format_aliases GTK::Geometry::Tweetcart.aliases + GTK::Geometry::Tweetcart.aliases_extended }
*** Primitive Conversions
#{ format_aliases GTK::Primitive::ConversionCapabilities::Tweetcart.aliases }
*** Array
#{ format_aliases GTK::ArrayTweetcart.aliases }
*** Hash
#{ format_aliases GTK::HashTweetcart.aliases }
*** Numerics
#{ format_aliases GTK::NumericTweetcart.aliases + GTK::FixnumTweetcart.aliases }

        S
      end
SRC
  end
end

module GTK::Tweetcart
  extend Docs
  extend TweetcartDocs
end