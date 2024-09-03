
module Echarts
  module Speedometer
    # Computes the percentage of a value within a given range.
    #
    # @param value [Numeric] The value to compute the percentage for.
    # @param lower_bound [Numeric] The lower bound of the range.
    # @param upper_bound [Numeric] The upper bound of the range.
    # @return [Float] The percentage of the value within the range.
    def self.compute_percentage(value, lower_bound, upper_bound)
      (value - lower_bound) / (upper_bound - lower_bound)
    end

    # Computes the angle for a given value.
    #
    # @param value [Float] The value to compute the angle for.
    # @return [Float] The angle in degrees.
    def self.compute_angle(value)
      # Compute the angles from the percentages knowing that the startAngle = 225 and the endAngle = -45 clockwise
      225 - (value * 270)
    end

    # Computes the angles for a given value and the minimum and maximum values in percentage.
    #
    # @param value_in_percentage [Float] The value in percentage.
    # @param min_in_percentage [Float] The minimum value in percentage.
    # @param max_in_percentage [Float] The maximum value in percentage.
    # @return [Array<Float>] The minimum angle, maximum angle, and value angle in degrees.
    def self.compute_angles(value_in_percentage, min_in_percentage, max_in_percentage)
      min_angle = compute_angle(min_in_percentage)
      max_angle = compute_angle(max_in_percentage)
      value_angle = compute_angle(value_in_percentage)

      return min_angle, max_angle, value_angle
    end

    # Computes the color for the gauge chart based on the minimum and maximum values.
    #
    # @param min [Numeric] The minimum value.
    # @param max [Numeric] The maximum value.
    # @param min_in_percentage [Float] The minimum value in percentage.
    # @param max_in_percentage [Float] The maximum value in percentage.
    # @param color_ok [String] The color for values within the range.
    # @param color_error [String] The color for values outside the range.
    # @param color_generic [String] The color for generic values.
    # @return [Array<Array>] An array of color values and their corresponding percentages.
    def self.compute_color(min, max, min_in_percentage, max_in_percentage, color_ok = "limegreen", color_error = "tomato", color_generic = "dodgerblue")
      color = []
      color << [min_in_percentage, color_error] if !min.zero? && (max > min || max.zero?)
      color << [max_in_percentage, color_ok] if !max.zero? && (max > min || min.zero?)
      color << [1, max > min ? color_error : ( max == min && max != 0 || max == 0 && min ==0 ? color_generic : color_ok )] 

      color
    end

    # Computes the options for the gauge chart.
    #
    # @param value [Numeric] The value to display on the gauge chart.
    # @param min [Numeric] The minimum value.
    # @param max [Numeric] The maximum value.
    # @param lower_bound [Numeric] The lower bound of the range.
    # @param upper_bound [Numeric] The upper bound of the range.
    # @param measure_unit [String] The unit of measurement for the value.
    # @param name [String] The name of the gauge chart.
    # @param color_ok [String] The color for values within the range.
    # @param color_error [String] The color for values outside the range.
    # @param color_generic [String] The color for generic values.
    # @return [Hash] The options for the gauge chart.
    def self.get_config(value, min, max, lower_bound, upper_bound, measure_unit, name, color_ok = "limegreen", color_error = "tomato", color_generic = "dodgerblue")
      min_in_percentage = compute_percentage(min, lower_bound, upper_bound)
      max_in_percentage = compute_percentage(max, lower_bound, upper_bound)
      value_in_percentage = compute_percentage(value, lower_bound, upper_bound)

      color = compute_color(min, max, min_in_percentage, max_in_percentage, color_ok, color_error, color_generic)
      min_angle, max_angle, value_angle = compute_angles(value_in_percentage, min_in_percentage, max_in_percentage)

      # The gauge chart
      raw_js_options = {
        series: [
          {
            type: "gauge",
            min: lower_bound,
            max: upper_bound,
            splitNumber: ((upper_bound - lower_bound) / lower_bound).abs,
            axisLine: {
              lineStyle: {
                width: 30,
                color: color,
              },
            },
            pointer: {
              itemStyle: {
                color: "auto",
              },
            },
            axisTick: {
              distance: -30,
              length: 8,
              lineStyle: {
                color: "#fff",
                width: 2,
              },
            },
            splitLine: {
              distance: -30,
              length: 30,
              lineStyle: {
                color: "#fff",
                width: 4,
              },
            },
            axisLabel: {
              color: "inherit",
              distance: 40,
              fontSize: 20,
            },
            detail: {
              valueAnimation: true,
              # formatter: "#{value.to_i}#{measure_unit}",
              color: "inherit",
            },
            data: [
              {
                value: value,
                name: name,
              },
            ],
          },
          # Dummy Gauge to be used to show the min max thresholds
          {
            type: "gauge",
            z: 3,
            startAngle: min_angle, # Here you can dinamically change the value
            min: min,
            endAngle: max_angle, # Here you can dinamically change the value
            max: max,
            splitNumber: 1,
            axisLabel: {
              distance: -24,
            },
            axisTick: {
              show: false,
            },
            axisLine: {
              lineStyle: {
                width: 0,
              },
            },
            splitLine: {
              distance: -12,
              # length: 50,
              lineStyle: {
                width: 0,
              },
            },
          },
        ],
      }
      
      return raw_js_options
    end
  end
end
