require 'pry'
require_relative('Wheel')
require_relative('Cassette')

module Bicycle
  class Gear
    attr_reader :chainring, :cassette, :wheel 

    def initialize(args={})
      @chainring     = args[:chainring] || {big: 53, small:39}
      @cassette      = args[:cassette] || Cassette.new()
      @wheel         = args[:wheel] || Wheel.new() 
    end

    def ratio(args={})
      chainring_size = args[:chainring_size] || :big
      speed = args[:speed] || 1
      (chainring[chainring_size]/cassette.gear(speed).to_f).round(2)
    end

    def ratios(args={})
      chainring_size = args[:chainring_size] || :big
      cassette.speeds.map do |speed|
        (chainring[chainring_size] / speed.to_f).round(2)
      end
    end

    def gear_inches(args={})
      (ratio(args) * wheel.diameter_to_inches).round(2)
    end

    def gear_millimeters(args={})
      (ratio(args) * wheel.diameter).round(2)
    end

    def jump_ratio

    end

  end
end

wheel = Bicycle::Wheel.new()
cassette = Bicycle::Cassette.new()
gear = Bicycle::Gear.new(cassette: cassette, wheel: wheel)
binding.pry