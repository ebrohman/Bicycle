module Bicycle
  class Cassette
    attr_reader :speed_1, :speed_2, :speed_3, :speed_4, :speed_5, :speed_6, :speed_7, :speed_8, :speed_9, :speed_10, :speed_11, :speeds
    def initialize(args = [])
      @speed_1 = args[0] || 11
      @speed_2 = args[1] || 12
      @speed_3 = args[2] || 13
      @speed_4 = args[3] || 14
      @speed_5 = args[4] || 15
      @speed_6 = args[5] || 16
      @speed_7 = args[6] || 17
      @speed_8 = args[7] || 19
      @speed_9 = args[8] || 21
      @speed_10 = args[9] || 23
      @speed_11 = args[10] || 25
      @speeds =  instance_variables.map do |speed|
        instance_variable_get(speed)
      end 
    end

    def gear(speed)
      case speed
      when 1
        speed_1
      when 2
        speed_2
      when 3
        speed_3
      when 4
        speed_4
      when 5
        speed_5
      when 6
        speed_6
      when 7
        speed_7
      when 8
        speed_8
      when 9
        speed_9
      when 10
        speed_10
      when 11
        speed_11
      end
    end

    def first
      @speed_1 
    end

    def last
      @speed_11
    end
    
  end
end