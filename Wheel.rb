module Bicycle
  class Wheel
    attr_reader :rim, :tire

    def initialize(args={})
      @rim = args[:rim] || 630
      @tire = args[:tire]  || 25
    end

    def diameter
      rim + (tire * 2) 
    end

    def diameter_to_inches
      diameter * 0.03937
    end

  end
end