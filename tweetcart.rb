module GTK
  class Args
    module Tweetcart
      def tc
        self.tick_count
      end

      def s
        self.state
      end

      def o
        outputs
      end

      def bg= color
        self.outputs.background_color= color
      end

      def os
        self.outputs.solids
      end

      def o_s
        self.outputs.static_solids
      end

      def osp
        self.outputs.sprites
      end

      def o_sp
        self.outputs.static_sprites
      end

      def op
        self.outputs.primitives
      end

      def o_p
        self.outputs.static_primitives
      end

      def ol
        self.outputs.labels
      end

      def o_l
        self.outputs.static_labels
      end

      def oli
        self.outputs.lines
      end

      def o_li
        self.outputs.static_lines
      end

      def ob
        self.outputs.borders
      end

      def o_b
        self.outputs.static_borders
      end

      # Persistence
      def ops
        self.outputs.ps
      end

      def opsc
        self.outputs.psc
      end
      # Persistence

      def i
        self.inputs
      end

      def ik
        self.inputs.keyboard
      end

      def il
        self.inputs.left
      end

      def ir
        self.inputs.right
      end

      def iu
        self.inputs.up
      end

      def id
        self.inputs.down
      end

      def ikd
        self.inputs.keyboard.key_down
      end

      def im
        self.inputs.mouse
      end

      def imc
        self.inputs.mouse.click
      end
    end
  end

  class Outputs
    module Tweetcart

      def ps # Persistent Outputs
        if @persistence_initialized
          unless @buffer_swap.new?
            @buffer_a, @buffer_b = @buffer_b, @buffer_a
            @buffer[:path] = @buffer_b

            self[@buffer_a].sprites << @buffer
            self.sprites << @buffer

            @buffer_swap = Kernel.tick_count
          end
        else
          @buffer_a = :persistent_buffer_a
          @buffer_b = :persistent_buffer_b

          self[@buffer_a]
          self[@buffer_b]

          @buffer = { w: 1280, h: 720 }.sprite
          @buffer_swap = Kernel.tick_count

          @persistence_initialized = true
        end

        self[@buffer_a]
      end

      def psc
        self[@buffer_a]
        self[@buffer_b]

        nil
      end

      def self.included(base)
        base.class_eval do
          alias_method :s,  :solids
          alias_method :sp, :sprites
          alias_method :p,  :primitives
          alias_method :l,  :labels
          alias_method :li, :lines
          alias_method :b,  :borders
          alias_method :d,  :debug

          alias_method :_s,  :static_solids
          alias_method :_sp, :static_sprites
          alias_method :_p,  :static_primitives
          alias_method :_l,  :static_labels
          alias_method :_li, :static_lines
          alias_method :_b,  :static_borders
          alias_method :_d,  :static_debug

          alias_method :bg=, :background_color=
        end
      end
    end
  end

  class Inputs
    module Tweetcart
      def self.included(base)
        base.class_eval do
          alias_method :u,  :up
          alias_method :d,  :down
          alias_method :l,  :left
          alias_method :r,  :right
          alias_method :lr, :left_right
          alias_method :ud, :up_down
          alias_method :dv, :directional_vector
          alias_method :t,  :text
          alias_method :m,  :mouse
          alias_method :c,  :click
          alias_method :c1, :controller_one
          alias_method :c2, :controller_two
          alias_method :k,  :keyboard
        end
      end
    end
  end

  class Keyboard
    module Tweetcart
      def self.included(base)
        base.class_eval do
          alias_method :ku, :key_up
          alias_method :kd, :key_down
          alias_method :kh, :key_held
          alias_method :hf, :has_focus
          alias_method :l,  :left
          alias_method :u,  :up
          alias_method :r,  :right
          alias_method :d,  :down
          alias_method :k,  :key
        end
      end
    end
  end

  class KeyboardKeys
    module Tweetcart
      def self.included(base)
        base.class_eval do
          alias_method :lr, :left_right
          alias_method :ud, :up_down
          alias_method :tk, :truthy_keys
        end
      end
    end
  end

  class Mouse
    module Tweetcart
      def self.included(base)
        base.class_eval do
          alias_method :p,    :point
          alias_method :inr?, :inside_rect?
          alias_method :ic?,  :inside_circle?
          alias_method :ir?,  :intersect_rect?

          alias_method :c,    :click
          alias_method :pc,   :previous_click

          alias_method :m,    :moved
          alias_method :ma,   :moved_at
          alias_method :gma,  :global_moved_at

          alias_method :u,    :up
          alias_method :d,    :down
          alias_method :bb,   :button_bits
          alias_method :bl,   :button_left
          alias_method :bm,   :button_middle
          alias_method :br,   :button_right
          alias_method :bx1,  :button_x1
          alias_method :bx2,  :button_x2
          alias_method :w,    :wheel

          alias_method :hf,   :has_focus
        end
      end
    end
  end

  class Grid
    module Tweetcart
      def self.included(base)
        base.class_eval do
          alias_method :n,    :name
          alias_method :b,    :bottom
          alias_method :t,    :top
          alias_method :l,    :left
          alias_method :r,    :right
          alias_method :re,   :rect
          alias_method :obl!, :origin_bottom_left!
          alias_method :oc!,  :origin_center!
        end
      end
    end
  end

  module Geometry
    module Tweetcart
      def self.included(base)
        base.module_eval do
          alias_method :inr?, :inside_rect?
          alias_method :ir?,  :intersect_rect?
          alias_method :sr,   :scale_rect
          alias_method :agt,  :angle_to
          alias_method :agf,  :angle_from
          alias_method :pic?, :point_inside_circle?
          alias_method :cir,  :center_inside_rect
          alias_method :cirx, :center_inside_rect_x
          alias_method :ciry, :center_inside_rect_y
          alias_method :ar,   :anchor_rect
        end
      end

      def self.extended(base)
        base.singleton_class.module_eval do
          alias_method :inr?, :inside_rect?
          alias_method :ir?,  :intersect_rect?
          alias_method :sr,   :scale_rect
          alias_method :agt,  :angle_to
          alias_method :agf,  :angle_from
          alias_method :pic?, :point_inside_circle?
          alias_method :cir,  :center_inside_rect
          alias_method :cirx, :center_inside_rect_x
          alias_method :ciry, :center_inside_rect_y
          # alias_method :ar,   :anchor_rect # FIXME :: Doesn't exist atm

          alias_method :sl,   :shift_line
          alias_method :lyi,  :line_y_intercept
          alias_method :abl,  :angle_between_lines
          alias_method :ls,   :line_slope
          alias_method :lrr,  :line_rise_run
          alias_method :rt,   :ray_test
          alias_method :lr,   :line_rect
          alias_method :li,   :line_intersect
          alias_method :d,    :distance
          alias_method :cb,   :cubic_bezier
        end
      end
    end
  end

  module Primitive
    module ConversionCapabilities
      module Tweetcart
        def self.included(base)
          base.module_eval do
            alias_method :s,  :solid
            alias_method :sp, :sprite
            alias_method :l,  :label
            alias_method :li, :line
            alias_method :bo, :border
          end
        end
      end
    end
  end

  module HashTweetcart
    def self.included(base)
      base.class_eval do
        alias_method :s,  :solid
        alias_method :sp, :sprite
        alias_method :l,  :label
        alias_method :li, :line
        alias_method :bo, :border
      end
    end
  end

  module Tweetcart
    include Math

    def csb(string, size_enum=nil, font='font.ttf')
      $gtk.calcstringbox(string, size_enum, font)
    end

    def self.setup_monkey_patches args
      args.class.include                             ::GTK::Args::Tweetcart
      args.outputs.class.include                     ::GTK::Outputs::Tweetcart
      args.inputs.class.include                      ::GTK::Inputs::Tweetcart
      args.inputs.keyboard.class.include             ::GTK::Keyboard::Tweetcart
      args.inputs.keyboard.key_down.class.include    ::GTK::KeyboardKeys::Tweetcart
      args.inputs.mouse.class.include                ::GTK::Mouse::Tweetcart
      args.grid.class.include                        ::GTK::Grid::Tweetcart
      args.geometry.include                          ::GTK::Geometry::Tweetcart
      args.geometry.extend                           ::GTK::Geometry::Tweetcart
      GTK::Primitive::ConversionCapabilities.include ::GTK::Primitive::ConversionCapabilities::Tweetcart
      Hash.include                                   ::GTK::HashTweetcart
      $top_level.include                             ::GTK::Tweetcart
    end

    def self.setup_textures args
      # setup :p 1 pixel texture
      args.outputs[:p].w = 1
      args.outputs[:p].h = 1
      args.outputs[:p].solids << {x: 0, y: 0, w: 1, h: 1, r: 255, g: 255, b: 255}

      # setup :c 720 diameter circle
      r = 360
      d = r * 2

      args.outputs[:c].w = d
      args.outputs[:c].h = d

      d.times do |i|
        h = i - r
        l = Math.sqrt(r * r - h * h)
        args.outputs[:c].lines << {x: i, y: r - l, x2: i, y2: r + l, r: 255, g: 255, b: 255}
      end
    end

    def self.setup args
      setup_monkey_patches args
      setup_textures args
    end
  end
end