module Echarts
  module MultipleVectors
    def self.get_config(stacks, legend, min, max, lower_bound, upper_bound, title, subtitle, xLabel, yLabel, color_min = "limegreen", color_max = "tomato")
      Rails.logger.debug("Legend: #{legend}\nLegend size: #{legend.size}")
      Rails.logger.debug("Stacks size: #{stacks.size}")
      {
        grid: {
          top: 80,
        },
        legend: {
          top: 80,
          show: true,
          data: legend,
          type: "scroll",
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
          name: xLabel,
        },
        yAxis: {
          type: "value",
          name: yLabel,
          # Set Upper and Lower bounds to the upper and lower bounds of the data
          min: lower_bound,
          max: upper_bound,
        },
        series: stacks.map.with_index do |stack, index|
          {
            name: legend[index],
            data: stack,
            type: "line",
            smooth: true,
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
                }
              ]
            }
          }
        end
      }
    end
  end
end
