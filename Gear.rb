require 'pry'
require_relative 'Wheel'
require_relative 'Cassette'

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
      speed = cassette.gear(args[:speed]) || cassette.first
      (chainring[chainring_size]/speed.to_f).round(2)
    end

    def ratios(args={})
      @ratios        =  Struct.new(:big, :small)
      big_ring_ratios = []
      small_ring_ratios = []
      cassette.speeds.each do |speed|
        big_ring_ratios << ( (chainring[:big].to_f / speed.to_f).round(2))
        small_ring_ratios << ( (chainring[:small].to_f / speed.to_f).round(2))
      end
      @ratios[big_ring_ratios, small_ring_ratios]
    end

    def top_bottom
      big_ring_ratios = [ (chainring[:big] / cassette.first.to_f).round(2), (chainring[:big] / cassette.last.to_f).round(2) ]
      small_ring_ratios = [ (chainring[:small] / cassette.first.to_f).round(2), (chainring[:small] / cassette.last.to_f).round(2) ]
      @top_bottom = Struct.new(:big, :small)
      @top_bottom[big_ring_ratios, small_ring_ratios]
    end

    def gear_inches(args={})
      (ratio(args) * wheel.diameter_to_inches).round(2)
    end

    def gear_millimeters(args={})
      (ratio(args) * wheel.diameter).round(2)
    end

    def jump_ratio
      (chainring[:big] / chainring[:small].to_f).round(2)
    end

  end
end



wheel = Bicycle::Wheel.new()
cassette = Bicycle::Cassette.new()
cassette2 = Bicycle::Cassette.new([11,12,13,14,15,16,17,19,21,23,25])

regular = Bicycle::Gear.new(cassette: cassette, wheel: wheel)

regular_25 = Bicycle::Gear.new(cassette: cassette2, wheel: wheel)

mid_compact = Bicycle::Gear.new(cassette: cassette, wheel: wheel, chainring: {big:52, small:36})

mid_compact_25 = Bicycle::Gear.new(cassette: cassette2, wheel: wheel, chainring: {big:52, small:36})

compact = Bicycle::Gear.new(cassette: cassette, wheel: wheel, chainring: {big:50, small:34})

compact_25 = Bicycle::Gear.new(cassette: cassette2, wheel: wheel, chainring: {big:50, small:34})


puts
puts "53/39 11-28"
p regular.ratios.big, regular.ratios.small, regular.top_bottom
puts
puts "53/39 11-25"
p regular_25.ratios.big, regular_25.ratios.small, regular_25.top_bottom
puts
puts "52/36 11-28"
p mid_compact.ratios.big, mid_compact.ratios.small, mid_compact.top_bottom
puts
puts "52/36 11-25"
p mid_compact_25.ratios.big, mid_compact_25.ratios.small, mid_compact_25.top_bottom
puts
puts"50/34 11-28"
p compact.ratios.big, compact.ratios.small, compact.top_bottom
puts
puts "50/34 11-25"
p compact_25.ratios.big, compact_25.ratios.small, compact_25.top_bottom
puts
