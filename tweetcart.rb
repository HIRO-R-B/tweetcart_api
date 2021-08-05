# coding: utf-8
# MIT License
# tweetcart.rb has been released under MIT (*only this file*).

# Contributors outside of DragonRuby who also hold Copyright:
# - https://github.com/HIRO-R-B
# - https://github.com/oeloeloel
# - https://github.com/leviongit

module GTK
  ##
  # Tweetcart: The main module
  module Tweetcart
    ##
    # Tweetcart Modules can extend `Tweetcart::(Include|Extend)`
    #
    # Provide an included/extended that define aliases (or log if they're missing)
    # on a base when the module's mixed
    ##

    ##
    # `aliases` must be defined on the module
    # and return an array of the form
    # [ new_method_alias, old_method_name,
    #   new_method_alias, old_method_name,
    #   ... ]
    module Include
      def included(base)
        tweetcart_aliases = aliases
        base.class_eval do
          tweetcart_aliases.each_slice(2) do |new, old|
            begin
              alias_method new, old
            rescue NameError => e
              Tweetcart.error_log << "#{e}"
            end
          end
        end
      end
    end

    ##
    # `singleton_aliases` must be defined on the module
    module Extend
      def extended(base)
        tweetcart_aliases = singleton_aliases
        base.singleton_class.class_eval do
          tweetcart_aliases.each_slice(2) do |new, old|
            begin
              alias_method new, old
            rescue NameError => e
              Tweetcart.error_log << "#{e}"
            end
          end
        end
      end
    end

    ##
    # Depreciated/Nonexistent methods will get collected here when Tweetcart modules get included
    def self.error_log
      @error_log ||= []
    end

    def self.error_log?
      !@error_log.nil?
    end

    ##
    # Tweetcart entry point
    def self.setup args
      setup_patches
      setup_textures args
    end

    def self.setup_patches
      GTK::Args.include                              ::GTK::Args::Tweetcart
      Numeric.include                                ::GTK::NumericTweetcart
      Object.include                                 ::GTK::ObjectTweetcart
      $top_level.include                             ::GTK::MainTweetcart
    end

    def self.setup_textures args
      # setup :p 1 pixel texture
      args.outputs[:p].w = 1
      args.outputs[:p].h = 1
      args.outputs[:p].solids << { x: 0, y: 0, w: 1, h: 1, r: 255, g: 255, b: 255 }

      # setup :c 720 diameter circle
      r = 360
      d = r * 2

      args.outputs[:c].w = d
      args.outputs[:c].h = d

      d.times do |i|
        h = i - r
        l = Math.sqrt(r * r - h * h)
        args.outputs[:c].lines << { x: i, y: r - l, x2: i, y2: r + l, r: 255, g: 255, b: 255 }
      end
    end
  end

  module MainTweetcart
    include Math

    F   = 255
    G   = 127
    W   = $args.grid.w
    H   = $args.grid.h
    N   = [nil]
    Z   = [0]
    S30 = 30.sin
    S60 = 60.sin

    ##
    # General circle centered at x and y
    def CI(x, y, radius, r=0, g=0, b=0, a=255)
      [(2*radius).to_square(x, y), :c, 0, a, r, g, b].sprite
    end
  end

  module Args::Tweetcart
    def self.aliases
      [
        :t,   'tick_count',
        :s,   'state',
        :i,   'inputs',
        :it,  'inputs.text',
        :k,   'inputs.keyboard',
        :l,   'inputs.left',
        :r,   'inputs.right',
        :u,   'inputs.up',
        :d,   'inputs.down',
        :kd,  'inputs.keyboard.key_down',
        :kh,  'inputs.keyboard.key_held',
        :ku,  'inputs.keyboard.key_up',
        :m,   'inputs.mouse',
        :mx,  'inputs.mouse.x',
        :my,  'inputs.mouse.y',
        :mc,  'inputs.mouse.click',
        :mw,  'inputs.mouse.wheel',
        :ml,  'inputs.mouse.button_left',
        :mm,  'inputs.mouse.button_middle',
        :mr,  'inputs.mouse.button_right',
        :o,   'outputs',
        :bc=, 'outputs.background_color=',
        :so,  'outputs.solids',
        :_so, 'outputs.static_solids',
        :sp,  'outputs.sprites',
        :_sp, 'outputs.static_sprites',
        :pr,  'outputs.primitives',
        :_pr, 'outputs.static_primitives',
        :la,  'outputs.labels',
        :_la, 'outputs.static_labels',
        :li,  'outputs.lines',
        :_li, 'outputs.static_lines',
        :bo,  'outputs.borders',
        :_bo, 'outputs.static_borders',
        :g,   'grid',
        :gre, 'grid.rect',
        :w,   'grid.w',
        :h,   'grid.h'
      ]
    end

    aliases.each_slice(2) do |m, ref|
      next instance_eval "define_method(:#{m}) { |arg| #{ref} arg }" if m.include?('=')
      instance_eval "define_method(:#{m}) { #{ref} }"
    end
  end

  module NumericTweetcart
    extend Tweetcart::Include

    def sin
      Math.sin(self.to_radians)
    end

    def cos
      Math.cos(self.to_radians)
    end

    def self.aliases
      [
        :d,   :idiv,
        :mwy, :map_with_ys,
        :m,   :map,
        :e,   :each
      ]
    end
  end

  module ObjectTweetcart
    extend Tweetcart::Include

    def SO! *opts
      $args.outputs.solids << opts
    end

    def SP! *opts
      $args.outputs.sprites << opts
    end

    def PR! *opts
      $args.outputs.primitives << opts
    end

    def LA! *opts
      $args.outputs.labels << opts
    end

    def LI! *opts
      $args.outputs.lines << opts
    end

    def BO! *opts
      $args.outputs.borders << opts
    end

    def _SO! *opts
      $args.outputs.static_solids << opts
    end

    def _SP! *opts
      $args.outputs.static_sprites << opts
    end

    def _PR! *opts
      $args.outputs.static_primitives << opts
    end

    def _LA! *opts
      $args.outputs.static_labels << opts
    end

    def _LI! *opts
      $args.outputs.static_labels << opts
    end

    def _BO! *opts
      $args.outputs.static_borders << opts
    end

    def PSO! *opts
      $args.outputs.p.solids << opts
    end

    def PSP! *opts
      $args.outputs.p.sprites << opts
    end

    def PPR! *opts
      $args.outputs.p.primitives << opts
    end

    def PLA! *opts
      $args.outputs.p.labels << opts
    end

    def PLI! *opts
      $args.outputs.p.lines << opts
    end

    def PBO! *opts
      $args.outputs.p.borders << opts
    end
  end
end
