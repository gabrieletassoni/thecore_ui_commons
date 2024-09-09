module Echarts
  module Binary
    def self.get_config(value, title, subtitle, yLabel)
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
          },
        },
        tooltip: {
          trigger: "axis",
        },
        series: [
          {
            name: 'Alert',
            type: 'pie',
            radius: '50%',
            data: [
              { value: value, name: yLabel, itemStyle: { color: value == 0 ? 'limegreen' : 'tomato' } },
            ],
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            },
          },
        ],
      }
    end
  end
end
