module Echarts
  module Vector
    def self.get_config(x, value, min, max, lower_bound, upper_bound, title, subtitle, xLabel, yLabel, color_min = "limegreen", color_max = "tomato", color_generic = "dodgerblue")
      # Rails.logger.debug("X: #{x.inspect}")
      {
        grid: {
          top: 80,
        },
        title: {
          text: title,
          subtext: subtitle,
        },
        toolbox: {
          feature: {
            saveAsImage: {},
            dataView: {},
            dataZoom: {},
            restore: {},
          },
        },
        tooltip: {
          trigger: "axis",
        },
        xAxis: {
          type: "category",
          data: x,
          name: xLabel,
        },
        yAxis: {
          type: "value",
          name: yLabel,
          min: lower_bound,
          max: upper_bound,
        },
        series: [
          {
            name: "Values",
            data: value,
            type: "line",
            smooth: true,
            # stack: 'Total',
            itemStyle: { color: color_generic },
            markLine: {
              data: [
                # Min  line (create an array repeating the min value for each x value)
                {
                  name: "Min Reference",
                  yAxis: min,
                  lineStyle: { color: color_min },
                },
                # Max line (create an array repeating the max value for each x value)
                {
                  name: "Max Reference",
                  yAxis: max,
                  lineStyle: { color: color_max },
                },
              ],
            },
          },
        ],
      }
    end
  end
end
