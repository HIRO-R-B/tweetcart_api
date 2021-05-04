# main.rb
require 'app/tweetcart.rb'
require 'app/tweetcart_docs.rb'

eval <<-S
def tick a
  if Kernel.global_tick_count == 0
    # Kernel.export_docs!
    GTK::Tweetcart.setup a
  end

  #{$gtk.read_file('app/tweet.rb')}
end

S

# $gtk.reset
# def tick args
  # if Kernel.global_tick_count == 0
    # Kernel.export_docs!
    # GTK::Tweetcart.setup args
  # end
  # t a
# end

