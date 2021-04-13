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
          alias_method :t,  :text
          alias_method :m,  :mouse
          alias_method :c1, :controller_one
          alias_method :c2, :controller_two
          alias_method :k,  :keyboard
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

  class Main
    module Tweetcart
      include Math

      def csb(string, size_enum=nil, font='font.ttf')
        $gtk.calcstringbox(string, size_enum, font)
      end
    end
  end
end