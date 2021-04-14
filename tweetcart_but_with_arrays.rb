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

      def ops # Persistent Outputs
        self.outputs.ps
      end

      def opsc # Persistent Outputs Clear
        self.outputs.psc
      end

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
          [
            :s,   :solids,
            :sp,  :sprites,
            :p,   :primitives,
            :l,   :labels,
            :li,  :lines,
            :b,   :borders,
            :d,   :debug,
            :_s,  :static_solids,
            :_sp, :static_sprites,
            :_p,  :static_primitives,
            :_l,  :static_labels,
            :_li, :static_lines,
            :_b,  :static_borders,
            :_d,  :static_debug,
            :bg=, :background_color=
          ].each_slice(2) { |new, old| alias_method new, old }
        end
      end
    end
  end

  class Inputs
    module Tweetcart
      def self.included(base)
        base.class_eval do
          [
            :u,  :up,
            :d,  :down,
            :l,  :left,
            :r,  :right,
            :lr, :left_right,
            :ud, :up_down,
            :dv, :directional_vector,
            :t,  :text,
            :m,  :mouse,
            :c,  :click,
            :c1, :controller_one,
            :c2, :controller_two,
            :k,  :keyboard
          ].each_slice(2) { |new, old| alias_method new, old }
        end
      end
    end
  end

  class Keyboard
    module Tweetcart
      def self.included(base)
        base.class_eval do
          [
            :ku, :key_up,
            :kd, :key_down,
            :kh, :key_held,
            :hf, :has_focus,
            :l,  :left,
            :u,  :up,
            :r,  :right,
            :d,  :down,
            :k,  :key
          ].each_slice(2) { |new, old| alias_method new, old }
        end
      end
    end
  end

  class KeyboardKeys
    module Tweetcart
      def self.included(base)
        base.class_eval do
          [
            :lr, :left_right,
            :ud, :up_down,
            :tk, :truthy_keys,
          ].each_slice(2) { |new, old| alias_method new, old }
        end
      end
    end
  end

  class Mouse
    module Tweetcart
      def self.included(base)
        base.class_eval do
          [
            :p,    :point,
            :inr?, :inside_rect?,
            :ic?,  :inside_circle?,
            :ir?,  :intersect_rect?,
            :c,    :click,
            :pc,   :previous_click,
            :m,    :moved,
            :ma,   :moved_at,
            :gma,  :global_moved_at,
            :u,    :up,
            :d,    :down,
            :bb,   :button_bits,
            :bl,   :button_left,
            :bm,   :button_middle,
            :br,   :button_right,
            :bx1,  :button_x1,
            :bx2,  :button_x2,
            :w,    :wheel,
            :hf,   :has_focus
          ].each_slice(2) { |new, old| alias_method new, old }
        end
      end
    end
  end

  class Grid
    module Tweetcart
      def self.included(base)
        base.class_eval do
          [
            :n,    :name,
            :b,    :bottom,
            :t,    :top,
            :l,    :left,
            :r,    :right,
            :re,   :rect,
            :obl!, :origin_bottom_left!,
            :oc!,  :origin_center!
          ].each_slice(2) { |new, old| alias_method new, old }
        end
      end
    end
  end

  module Geometry
    module Tweetcart
      def self.included(base)
        base.module_eval do
          [
            :inr?, :inside_rect?,
            :ir?,  :intersect_rect?,
            :sr,   :scale_rect,
            :agt,  :angle_to,
            :agf,  :angle_from,
            :pic?, :point_inside_circle?,
            :cir,  :center_inside_rect,
            :cirx, :center_inside_rect_x,
            :ciry, :center_inside_rect_y,
            :ar,   :anchor_rect
          ].each_slice(2) { |new, old| alias_method new, old }
        end
      end

      def self.extended(base)
        base.singleton_class.module_eval do
          [
            :inr?, :inside_rect?,
            :ir?,  :intersect_rect?,
            :sr,   :scale_rect,
            :agt,  :angle_to,
            :agf,  :angle_from,
            :pic?, :point_inside_circle?,
            :cir,  :center_inside_rect,
            :cirx, :center_inside_rect_x,
            :ciry, :center_inside_rect_y,
            # :ar,   :anchor_rect, # FIXME :: Doesn't exist atm
            :sl,   :shift_line,
            :lyi,  :line_y_intercept,
            :abl,  :angle_between_lines,
            :ls,   :line_slope,
            :lrr,  :line_rise_run,
            :rt,   :ray_test,
            :lr,   :line_rect,
            :li,   :line_intersect,
            :d,    :distance,
            :cb,   :cubic_bezier
          ].each_slice(2) { |new, old| alias_method new, old }
        end
      end
    end
  end

  module Primitive
    module ConversionCapabilities
      module Tweetcart
        def self.included(base)
          base.module_eval do
            [
              :s,  :solid,
              :sp, :sprite,
              :l,  :label,
              :li, :line,
              :bo, :border
          ].each_slice(2) { |new, old| alias_method new, old }
          end
        end
      end
    end
  end

  module NumericTweetcart
    def self.included(base)
      base.class_eval do
        [
          :s,   :seconds,
          :tb,  :to_byte,
          :cw,  :clamp_wrap,
          :et,  :elapsed_time,
          :etp, :elapsed_time_percent,
          :n?,  :new?,
          :e?,  :elapsed?,
          :fi,  :frame_index,
          :z?,  :zero?,
          :r,   :randomize,
          :rs,  :rand_sign,
          :rr,  :rand_ratio,
          :rd,  :remainder_of_divide,
          :ee,  :ease_extended,
          :ge,  :global_ease,
          :e,   :ease,
          :ese, :ease_spline_extended,
          :es,  :ease_spline,
          :tr,  :to_radians,
          :td,  :to_degrees,
          :ts,  :to_square,
          :v,   :vector,
          :vy,  :vector_y,
          :vx,  :vector_x,
          :xv,  :x_vector,
          :yv,  :y_vector,
          :mz?, :mod_zero?,
          :zm?, :zmod?,
          :fd,  :fdiv,
          :id,  :idiv,
          :t,   :towards,
          :mwy, :map_with_ys,
          :co,  :combinations,
          :c,   :cap,
          :cmm, :cap_min_max,
          :n,   :numbers,
          :m,   :map,
          :ea,  :each,
          :fr,  :from_right,
          :ft,  :from_top
        ].each_slice(2) { |new, old| alias_method new, old }
      end
    end
  end

  module FixnumTweetcart
    def self.included(base)
      base.class_eval do
        alias_method :ev?, :even?
        alias_method :od?, :odd?
      end
    end
  end

  module ArrayTweetcart
    def self.included(base)
      base.class_eval do
        alias_method :ir?, :intersect_rect?
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
      Array.include                                  ::GTK::ArrayTweetcart
      Hash.include                                   ::GTK::HashTweetcart
      Numeric.include                                ::GTK::NumericTweetcart
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