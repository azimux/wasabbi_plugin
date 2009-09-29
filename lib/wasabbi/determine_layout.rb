class Wasabbi
  module DetermineLayout
    def self.included base
      base.instance_eval do
        layout_proc = Wasabbi.layout_procs[base.controller_name] ||
          Wasabbi.layout_procs["wasabbi"]

        if layout_proc
          layout :determine_layout

          base.send(:define_method, :determine_layout) do
            layout_proc.call self
          end
        end
      end
    end
  end
end
