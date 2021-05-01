# coding: utf-8
# MIT License
# tweetcart.rb has been released under MIT (*only this file*).

# Contributors outside of DragonRuby who also hold Copyright:
# - https://github.com/HIRO-R-B
# - https://github.com/oeloeloel
# - https://github.com/leviongit

module GTK
  module Tweetcart
    include Math

    F = 255
    W = $args.grid.w
    H = $args.grid.h
    Z = [0]

    module P
      def self.do *attrs, &block
        Class.new do
          attr *attrs

          # NOTE: Yea, this class might not be a sprite,
          # but you can't push it into primitives without a valid primitive marker even if you have draw_override defined
          # So... ehh, for all intents and purposes, it's a "sprite"
          def primitive_marker
            :sprite
          end

          def initialize **opts
            opts.each { |k, v| send :"#{k}=", v }
          end

          define_method :draw_override, &block
        end
      end

      def self.so *attrs, &block
        self.do(:x, :y, :w, :h, :r, :g, :b, :a, *attrs, &block)
      end

      def self.sp *attrs, &block
        self.do(:x, :y, :w, :h, :p, :an, :a,
                :r, :g, :b,
                :tx, :ty, :tw, :th,
                :fh, :fv,
                :aax, :aay,
                :sx, :sy, :sw, :sh,
                *attrs, &block)
      end

      def self.la *attrs, &block
        self.do(:x, :y, :t, :sen, :aen, :r, :g, :b, :a, :f, *attrs, &block)
      end

      def self.li *attrs, &block
        self.do(:x, :y, :x2, :y2, :r, :g, :b, :a, *attrs, &block)
      end

      def self.bo *attrs, &block
        self.so(*attrs, &block)
      end

      def self.dso &draw_call
        Class.new do
          attr :x, :y, :w, :h, :r, :g, :b, :a
          def primitive_marker
            :solid
          end

          def initialize x=nil, y=nil, w=nil, h=nil, r=nil, g=nil, b=nil, a=nil
            @x=x
            @y=y
            @w=w
            @h=h
            @r=r
            @g=g
            @b=b
            @a=a
          end

          define_method :draw_call, &draw_call

          def draw_override(ffi)
            draw_call
            ffi.draw_solid(@x, @y, @w, @h, @r, @g, @b, @a)
          end
        end
      end

      def self.dsp path=nil, &draw_call
        path &&= path.to_s

        Class.new do
          attr :x, :y, :w, :h, :p, :an, :a,
               :r, :g, :b,
               :tx, :ty, :tw, :th,
               :fh, :fv,
               :aax, :aay,
               :sx, :sy, :sw, :sh
          def primitive_marker
            :sprite
          end

          define_method :initialize do |x=nil, y=nil, w=nil, h=nil, p=path, an=nil, a=nil,
                                        r=nil, g=nil, b=nil,
                                        tx=nil, ty=nil, tw=nil, th=nil,
                                        fh=nil, fv=nil,
                                        aax=nil, aay=nil,
                                        sx=nil, sy=nil, sw=nil, sh=nil,
                                        **opts|
            @x   = x
            @y   = y
            @w   = w
            @h   = h
            @p   = p
            @an  = an
            @a   = a
            @r   = r
            @g   = g
            @b   = b
            @tx  = tx
            @ty  = ty
            @tw  = tw
            @th  = th
            @fh  = fh
            @fv  = fv
            @aax = aax
            @aay = aay
            @sx  = sx
            @sy  = sy
            @sw  = sw
            @sh  = sh
            opts.each { |k, v| send :"#{k}=", v }
          end

          define_method :draw_call, &draw_call

          def draw_override(ffi)
            draw_call
            ffi.draw_sprite_3(@x, @y, @w, @h, @p, @an, @a,
                              @r, @g, @b,
                              @tx, @ty, @tw, @th,
                              @fh, @fv,
                              @aax, @aay,
                              @sx, @sy, @sw, @sh)
          end
        end
      end

      def self.dla &draw_call
        Class.new do
          attr :x, :y, :t, :sen, :aen, :r, :g, :b, :a, :f
          def primitive_marker
            :label
          end

          def initialize x=nil, y=nil, t=nil, sen=nil, aen=nil, r=nil, g=nil, b=nil, a=nil, f=nil, **opts
            @x   = x
            @y   = y
            @t   = t
            @sen = sen
            @aen = aen
            @r   = r
            @g   = g
            @b   = b
            @a   = a
            @f   = f
            opts.each { |k, v| send :"#{k}=", v }
          end

          define_method :draw_call, &draw_call

          def draw_override(ffi)
            draw_call
            ffi.draw_label(@x, @y, @t, @sen, @aen, @r, @g, @b, @a, @f)
          end
        end
      end

      def self.dli &draw_call
        Class.new do
          attr :x, :y, :x2, :y2, :r, :g, :b, :a
          def primitive_marker
            :line
          end

          def initialize x=nil, y=nil, x2=nil, y2=nil, r=nil, g=nil, b=nil, a=nil, **opts
            @x  = x
            @y  = y
            @x2 = x2
            @y2 = y2
            @r  = r
            @g  = g
            @b  = b
            @a  = a
            opts.each { |k, v| send :"#{k}=", v }
          end

          define_method :draw_call, &draw_call

          def draw_override(ffi)
            draw_call
            ffi.draw_line(@x, @y, @x2, @y2, @r, @g, @b, @a)
          end
        end
      end

      def self.dbo &draw_call
        Class.new do
          attr :x, :y, :w, :h, :r, :g, :b, :a
          def primitive_marker
            :border
          end

          def initialize x=nil, y=nil, w=nil, h=nil, r=nil, g=nil, b=nil, a=nil, **opts
            @x = x
            @y = y
            @w = w
            @h = h
            @r = r
            @g = g
            @b = b
            @a = a
            opts.each { |k, v| send :"#{k}=", v }
          end

          define_method :draw_call, &draw_call

          def draw_override(ffi)
            draw_call
            ffi.draw_border(@x, @y, @w, @h, @r, @g, @b, @a)
          end
        end
      end
    end

    def CI(x, y, radius, r=0, g=0, b=0, a=255)
      [radius.to_square(x, y), :c, 0, a, r, g, b].sprite
    end

    def csb(string, size_enum = nil, font = 'font.ttf')
      $gtk.calcstringbox(string, size_enum, font)
    end

    def sum(*args)
      $args.fn.+(*args)
    end

    def self.aliases
      [
        :csb, 'args.gtk.calcstringbox',
        :sum, 'args.fn.+',
      ]
    end

    # Depreciated/Nonexistent methods will get collected here when Tweetcart.setup is run
    def self.error_log
      @error_log ||= []
    end

    def self.error_log?
      !@error_log.nil?
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
      FFI::Draw.include                              ::GTK::FFIDrawTweetcart

      Enumerable.include                             ::GTK::EnumerableTweetcart
      Array.include                                  ::GTK::ArrayTweetcart
      Hash.include                                   ::GTK::HashTweetcart
      Numeric.include                                ::GTK::NumericTweetcart
      Fixnum.include                                 ::GTK::FixnumTweetcart
      Symbol.include                                 ::GTK::SymbolTweetcart
      Module.include                                 ::GTK::ModuleTweetcart
      Object.include                                 ::GTK::ObjectTweetcart

      $top_level.include                             ::GTK::Tweetcart
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

    def self.setup args
      setup_monkey_patches args
      setup_textures args
    end
  end

  tweetcart_included = Module.new do
    def included(base)
      tweetcart_aliases = aliases
      base.class_eval do
        tweetcart_aliases.each_slice(2) do |new, old|
          begin
            alias_method new, old
          rescue NameError => e
            GTK::Tweetcart.error_log << "#{e}"
          end
        end
      end
    end
  end

  tweetcart_extended = Module.new do
    def extended(base)
      tweetcart_aliases = singleton_aliases
      base.singleton_class.class_eval do
        tweetcart_aliases.each_slice(2) do |new, old|
          begin
            alias_method new, old
          rescue NameError => e
            GTK::Tweetcart.error_log << "#{e}"
          end
        end
      end
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
        :mc,  'inputs.mouse.click',
        :mw,  'inputs.mouse.wheel',
        :ml,  'inputs.mouse.button_left',
        :mm,  'inputs.mouse.button_middle',
        :mr,  'inputs.mouse.button_right',
        :o,   'outputs',
        :bg=, 'outputs.background_color=',
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
        :p,   'outputs.p',  # Persistent Outputs
        :pc,  'outputs.pc', # Persistent Outputs clear
        :g,   'grid',
        :gre, 'grid.rect',
        :w,   'grid.w',
        :h,   'grid.h'
      ]
    end

    aliases.each_slice(2) do |m, ref|
      if m.include?('=')
        instance_eval "define_method(:#{m}) { |arg| #{ref} arg }"
        next
      end

      instance_eval "define_method(:#{m}) { #{ref} }"
    end
  end

  Outputs::Tweetcart = Module.new do
    extend tweetcart_included

    def p # Persistent Outputs
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

    def pc
      self[@buffer_a]
      self[@buffer_b]

      nil
    end

    def self.aliases
      [
        :so,  :solids,
        :sp,  :sprites,
        :pr,  :primitives,
        :la,  :labels,
        :li,  :lines,
        :bo,  :borders,
        :de,  :debug,
        :_so, :static_solids,
        :_sp, :static_sprites,
        :_pr, :static_primitives,
        :_la, :static_labels,
        :_li, :static_lines,
        :_bo, :static_borders,
        :_de, :static_debug,
        :bg=, :background_color=
      ]
    end
  end

  Inputs::Tweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
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
      ]
    end
  end

  Keyboard::Tweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
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
      ]
    end
  end

  KeyboardKeys::Tweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
      [
        :lr, :left_right,
        :ud, :up_down,
        :tk, :truthy_keys,
      ]
    end
  end

  Mouse::Tweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
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
        :b,    :button_bits,
        :l,    :button_left,
        :m,    :button_middle,
        :r,    :button_right,
        :x1,   :button_x1,
        :x2,   :button_x2,
        :w,    :wheel,
        :hf,   :has_focus
      ]
    end
  end

  Grid::Tweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
      [
        :n,    :name,
        :b,    :bottom,
        :t,    :top,
        :l,    :left,
        :r,    :right,
        :re,   :rect,
        :obl!, :origin_bottom_left!,
        :oc!,  :origin_center!
      ]
    end
  end

  Geometry::Tweetcart = Module.new do
    extend tweetcart_included
    extend tweetcart_extended

    def self.aliases
      [
        :inr?, :inside_rect?,
        :ir?,  :intersect_rect?,
        :sr,   :scale_rect,
        :ant,  :angle_to,
        :anf,  :angle_from,
        :pic?, :point_inside_circle?,
        :cir,  :center_inside_rect,
        :cirx, :center_inside_rect_x,
        :ciry, :center_inside_rect_y,
        :ar,   :anchor_rect
      ]
    end

    # FIXME:: Anchor rect doesn't exist on the Geometry Class atm
    def self.singleton_aliases
      aliases + [
        :sl,  :shift_line,
        :lyi, :line_y_intercept,
        :abl, :angle_between_lines,
        :ls,  :line_slope,
        :lrr, :line_rise_run,
        :rt,  :ray_test,
        :lr,  :line_rect,
        :li,  :line_intersect,
        :d,   :distance,
        :cb,  :cubic_bezier
      ]
    end
  end

  Primitive::ConversionCapabilities::Tweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
      [
        :so, :solid,
        :sp, :sprite,
        :la, :label,
        :li, :line,
        :bo, :border
      ]
    end
  end

  FFIDrawTweetcart = Module.new do
    def dso(x, y, w, h, r=nil, g=nil, b=nil, a=nil)
      draw_solid(x, y, w, h, r, g, b, a)
    end

    def dsp(x, y, w, h, path, angle=nil, a=nil,
            r=nil, g=nil, b=nil,
            tile_x=nil, tile_y=nil, tile_w=nil, tile_h=nil,
            flip_horizontally=nil, flip_vertically=nil,
            angle_anchor_x=nil, angle_anchor_y=nil,
            source_x=nil, source_y=nil, source_w=nil, source_h=nil)

      draw_sprite_3(x, y, w, h, path,
                    angle,
                    a, r, g, b,
                    tile_x, tile_y, tile_w, tile_h,
                    flip_horizontally, flip_vertically,
                    angle_anchor_x, angle_anchor_y,
                    source_x, source_y, source_w, source_h)
    end

    def dla(x, y, text,
            size_enum=nil, alignment_enum=nil,
            r=nil, g=nil, b=nil, a=nil,
            font=nil)

      draw_label(x, y, text,
                 size_enum, alignment_enum,
                 r, g, b, a,
                 font)
    end

    def dli(x, y, x2, y2, r=nil, g=nil, b=nil, a=nil)
      draw_line(x, y, x2, y2, r, g, b, a)
    end

    def dbo(x, y, w, h, r=nil, g=nil, b=nil, a=nil)
      draw_border(x, y, w, h, r, g, b, a)
    end
  end

  EnumerableTweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
      [
        :cy,  :cycle,
        :dw,  :drop_while,
        :ec,  :each_cons,
        :es,  :each_slice,
        :ewi, :each_with_index,
        :ewo, :each_with_object,
        :en,  :entries,
        :fa,  :find_all,
        :fi,  :find_index,
        :f,   :first,
        :fm,  :flat_map,
        :gb,  :group_by,
        :i?,  :include?,
        :m,   :map,
        :m?,  :member?,
        :mx,  :max,
        :mxb, :max_by,
        :mn,  :min,
        :mnb, :min_by,
        :mm,  :minmax,
        :mmb, :minmax_by,
        :n?,  :none?,
        :o?,  :one?,
        :pa,  :partition,
        :rd,  :reduce,
        :rj,  :reject,
        :rve, :reverse_each,
        :se,  :select,
        :stb, :sort_by,
        :tw,  :take_while
      ]
    end
  end

  ArrayTweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
      [
        :an,   :angle,
        :an=,  :angle=,
        :ant,  :angle_to,
        :anf,  :angle_from,
        :agp,  :angle_given_point,
        :air?, :any_intersect_rect?,
        :ap,   :append,
        :cir,  :center_inside_rect,
        :c,    :clear,
        :cl,   :clone,
        :co,   :combination,
        :cp,   :compact,
        :cp!,  :compact!,
        :d,    :delete,
        :da,   :delete_at,
        :di,   :delete_if,
        :e,    :each,
        :ei,   :each_index,
        :e?,   :empty?,
        :fe,   :fetch,
        :fl,   :flatten,
        :fl!,  :flatten!,
        :ir?,  :intersect_rect?,
        :j,    :join,
        :ki,   :keep_if,
        :l,    :length,
        :m!,   :map!,
        :mwi,  :map_with_index,
        :pe,   :permutation,
        :pr,   :product,
        :re,   :rect,
        :rs,   :rect_shift,
        :rj!,  :reject!,
        :rjf,  :reject_false,
        :rjy,  :reject_falsey,
        :rjn,  :reject_nil,
        :rp,   :replace,
        :rv,   :reverse,
        :rv!,  :reverse!,
        :ro,   :rotate,
        :ro!,  :rotate!,
        :sa,   :sample,
        :sr,   :scale_rect,
        :sre,  :scale_rect_extended,
        :se!,  :select!,
        :st,   :shift,
        :str,  :shift_rect,
        :sh,   :shuffle,
        :sh!,  :shuffle!,
        :sl,   :slice,
        :sl!,  :slice!,
        :s,    :sort,
        :s!,   :sort!,
        :tr,   :transpose,
        :ust,  :unshift,
        :va,   :values_at
      ]
    end
  end

  HashTweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
      [
        :so,   :solid,
        :sp,   :sprite,
        :la,   :label,
        :li,   :line,
        :bo,   :border,

        :sen,  :size_enum,
        :sen=, :size_enum=,
        :aen,  :alignment_enum,
        :aen=, :alignment_enum=,
        :an,   :angle,
        :an=,  :angle=,
        :aax,  :angle_anchor_x,
        :aax=, :angle_anchor_x=,
        :aay,  :angle_anchor_y,
        :aay=, :angle_anchor_y=,
        :agp,  :angle_given_point,
        :fh,   :flip_horizontally,
        :fh=,  :flip_horizontally=,
        :fv,   :flip_vertically,
        :fv=,  :flip_vertically=,
        :sx,   :source_x,
        :sx=,  :source_x=,
        :sy,   :source_y,
        :sy=,  :source_y=,
        :sw,   :source_w,
        :sw=,  :source_w=,
        :sh,   :source_h,
        :sh=,  :source_h=,

        :c,    :clear,
        :cl,   :clone,
        :co,   :compact,
        :co!,  :compact!,
        :df,   :default,
        :df=,  :default=,
        :dp,   :default_proc,
        :dp=,  :default_proc=,
        :d,    :delete,
        :di,   :delete_if,
        :dt,   :detect,
        :e,    :each,
        :e?,   :empty?,
        :ev,   :each_value,
        :fe,   :fetch,
        :fev,  :fetch_values,
        :fl,   :flatten,
        :hk?,  :has_key?,
        :hv?,  :has_value?,
        :ki,   :keep_if,
        :l,    :length,
        :me,   :merge,
        :me!,  :merge!,
        :rj!,  :reject!,
        :rp,   :replace,
        :sre,  :scale_rect_extended,
        :se!,  :select!,
        :st,   :shift,
        :str,  :shift_rect,
        :sl,   :slice,
        :s,    :sort,
      ]
    end
  end

  NumericTweetcart = Module.new do
    extend tweetcart_included

    def r
      rand_ratio.to_i
    end

    def dm(x)
      divmod(x)
    end

    def sin
      Math.sin(self.to_radians)
    end

    def cos
      Math.cos(self.to_radians)
    end

    def self.aliases
      [
        :a,   :abs,

        :s,   :seconds,
        :tb,  :to_byte,
        :cw,  :clamp_wrap,
        :et,  :elapsed_time,
        :etp, :elapsed_time_percent,
        :n?,  :new?,
        :e?,  :elapsed?,
        :fi,  :frame_index,
        :z?,  :zero?,
        :rs,  :rand_sign,
        :rr,  :rand_ratio,
        :rd,  :remainder_of_divide,
        :ea,  :ease,
        :ee,  :ease_extended,
        :ge,  :global_ease,
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
        :d,   :idiv,
        :to,  :towards,
        :mwy, :map_with_ys,
        :co,  :combinations,
        :c,   :cap,
        :cmm, :cap_min_max,
        :n,   :numbers,
        :m,   :map,
        :e,   :each,
        :fr,  :from_right,
        :ft,  :from_top
      ]
    end
  end

  FixnumTweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
      [
        :t,   :times,
        :ev?, :even?,
        :od?, :odd?
      ]
    end
  end

  SymbolTweetcart = Module.new do
    def [] *args, &block
      -> caller, *rest { caller.send self, *rest, *args, &block }
    end
  end

  ModuleTweetcart = Module.new do
    extend tweetcart_included

    def self.aliases
      [
        :dm, :define_method,
      ]
    end
  end

  ObjectTweetcart = Module.new do
    extend tweetcart_included

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
      $args.outputs.labels << opts
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

    def PC!
      $args.outputs.pc
    end

    def self.aliases
      [
        :dsm, :define_singleton_method
      ]
    end
  end
end
