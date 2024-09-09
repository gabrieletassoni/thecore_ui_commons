module Echarts
  module BinarySeries
    def self.get_config(x, values, title, subtitle, xLabel, yLabel)
      Rails.logger.debug("X: #{x}\nValues: #{values}")
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
          name: yLabel
        },
        # Data series is always 1 for each element in x array
        # The color of the bar (the graph is a bargraph) depends 
        # on the value, if it's 1, then it's red, otherwise it's green
        series: [
          {
            name: "Values",
            data: x.map.with_index { |_, index| { value: 1, itemStyle: { color: values[index].to_i == 1 ? 'tomato' : 'limegreen' } } },
            type: "bar"
          },
        ],
      }
    end
  end
end
