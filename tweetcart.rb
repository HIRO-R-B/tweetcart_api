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

    ##
    # General circle centered at x and y
    def CI(x, y, radius, r=0, g=0, b=0, a=255)
      [(2*radius).to_square(x, y), :c, 0, a, r, g, b].sprite
    end
  end

  module Args::Tweetcart
    ##
    # `aliases` must be defined on the module
    # and return an array of the form
    # [ new_method_alias, old_method_name,
    #   new_method_alias, old_method_name,
    #   ... ]
    def self.aliases
      [
        :t,   'tick_count',
        :s,   'state',
        :i,   'inputs',
        :i_t,  'inputs.text',
        :k,   'inputs.keyboard',
        :l,   'inputs.left',
        :r,   'inputs.right',
        :u,   'inputs.up',
        :d,   'inputs.down',
        :k_d,  'inputs.keyboard.key_down',
        :k_h,  'inputs.keyboard.key_held',
        :k_u,  'inputs.keyboard.key_up',
        :m,   'inputs.mouse',
        :m_x,  'inputs.mouse.x',
        :m_y,  'inputs.mouse.y',
        :m_c,  'inputs.mouse.click',
        :m_w,  'inputs.mouse.wheel',
        :m_l,  'inputs.mouse.button_left',
        :m_m,  'inputs.mouse.button_middle',
        :m_r,  'inputs.mouse.button_right',
        :o,   'outputs',
        :bc=, 'outputs.background_color=',
        :sol,  'outputs.solids',
        :_sol, 'outputs.static_solids',
        :spr,  'outputs.sprites',
        :_spr, 'outputs.static_sprites',
        :pri,  'outputs.primitives',
        :_pri, 'outputs.static_primitives',
        :lab,  'outputs.labels',
        :_lab, 'outputs.static_labels',
        :lin,  'outputs.lines',
        :_lin, 'outputs.static_lines',
        :bor,  'outputs.borders',
        :_bor, 'outputs.static_borders',
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
    def sin
      Math.sin(self.to_radians)
    end

    def cos
      Math.cos(self.to_radians)
    end
  end

  module ObjectTweetcart
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
  end
end
