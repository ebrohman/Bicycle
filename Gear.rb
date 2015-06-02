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
cassette28 = Bicycle::Cassette.new()
cassette26 = Bicycle::Cassette.new([11,12,13,14,15,16,17,19,21,23,26])
cassette25 = Bicycle::Cassette.new([11,12,13,14,15,16,17,19,21,23,25])
chainring_mid = { big: 52, small: 36 }
chainring_compact = { big: 50, small: 34 }

regular = Bicycle::Gear.new(cassette: cassette28, wheel: wheel)
regular_25 = Bicycle::Gear.new(cassette: cassette25, wheel: wheel)
regular_26 = Bicycle::Gear.new(cassette: cassette26, wheel: wheel)

mid_compact = Bicycle::Gear.new(cassette: cassette28, wheel: wheel, chainring: chainring_mid)
mid_compact_25 = Bicycle::Gear.new(cassette: cassette25, wheel: wheel, chainring: chainring_mid)
mid_compact_26 = Bicycle::Gear.new(cassette: cassette26, wheel: wheel, chainring: chainring_mid)

compact = Bicycle::Gear.new(cassette: cassette28, wheel: wheel, chainring: chainring_compact)
compact_25 = Bicycle::Gear.new(cassette: cassette25, wheel: wheel, chainring: chainring_compact)
compact_26 = Bicycle::Gear.new(cassette: cassette26, wheel: wheel, chainring: chainring_compact)

########
puts
puts "53/39 11-28"
p regular.ratios.big, regular.ratios.small, regular.jump_ratio
puts
puts "53/39 11-26"
p regular_26.ratios.big, regular_26.ratios.small, regular_26.jump_ratio
puts
puts "53/39 11-25"
p regular_25.ratios.big, regular_25.ratios.small, regular_25.jump_ratio
puts
########
puts "52/36 11-28"
p mid_compact.ratios.big, mid_compact.ratios.small, mid_compact.jump_ratio
puts
puts "52/36 11-26"
p mid_compact_26.ratios.big, mid_compact_26.ratios.small, mid_compact_26.jump_ratio
puts
puts "52/36 11-25"
p mid_compact_25.ratios.big, mid_compact_25.ratios.small, mid_compact_25.jump_ratio
########
puts
puts"50/34 11-28"
p compact.ratios.big, compact.ratios.small, compact.jump_ratio
puts
puts "50/34 11-26"
p compact_26.ratios.big, compact_26.ratios.small, compact_26.jump_ratio
puts
puts "50/34 11-25"
p compact_25.ratios.big, compact_25.ratios.small, compact_25.jump_ratio
puts
