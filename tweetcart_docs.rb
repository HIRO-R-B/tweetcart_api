module TweetcartDocs
  def docs_method_sort_order
    [
      :docs_class,
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
    a.o.s << [m.x, m.y, 10, 10] # args.outputs.solids << [m.x, m.y, 10, 10]
  end
#+end_src

S
  end

  def docs_persistent_outputs
    
  end

  def self.format_aliases aliases
    aliases.each_slice(2).map { |new, old| "- ~#{new}~  |  ~#{old}~" }.join("\n")
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
#{ format_aliases GTK::Geometry::Tweetcart.aliases }
#{ format_aliases GTK::Geometry::Tweetcart.aliases_extended }
*** Primitive Conversions
#{ format_aliases GTK::Primitive::ConversionCapabilities::Tweetcart.aliases }
*** Array
#{ format_aliases GTK::ArrayTweetcart.aliases }
*** Hash
#{ format_aliases GTK::HashTweetcart.aliases }
*** Numerics
#{ format_aliases GTK::NumericTweetcart.aliases }
#{ format_aliases GTK::FixnumTweetcart.aliases }

        S
      end
SRC
  end
end

module GTK::Tweetcart
  extend Docs
  extend TweetcartDocs
end