require 'date'
module Helpers
    module ChartsHelper
        # Please override this in your gems to add charts, here some
        # working, but commented out charts as example.

        # def candlestick_data
        #     @acc = rand(6570..6650)
        #     60.times.map {|i| [Date.today - 60 + i, ohlc] }.to_h
        # end
        
        # def ohlc
        #     open = @acc + rand(-20..20)
        #     high = open + rand(0..100)
        #     low = open - rand(0..100)
        #     @acc = close = open + rand(-((high-low)/3)..((high-low)/2))
        #     [open, high, low, close]
        # end

        # ### HIGH PRIORITY CHARTS
        # def charts_high_pie_demo
        #     pie_chart([{name: "Series A", data: 25},{name: "Series B", data: 100},{name: "Series C", data: 200},{name: "Series D", data: 125}], legend: "left")
        # end

        # def charts_high_candlestick_demo
        #     candlestick_options = {plot_options: {candlestick: {colors: {upward: '#3C90EB',downward: '#DF7D46'}}}}
        #     candlestick_chart(candlestick_data, candlestick_options)
        # end
        
        # ### MEDIUM PRIORITY CHARTS
        # def charts_medium_radar_demo
        #     radar_series = [{name: "What it should be",data: { "Code review"=>10, "Issues"=>5, "Pull request"=>25, "Commits"=>60 }},{name: "What it really is",data: { "Code review"=>1, "Issues"=>3, "Pull request"=>7, "Commits"=>89 }}]
        #     radar_chart(radar_series,{title: "GitHub Radar", markers: {size: 4}, theme: 'palette4'})
        # end

        # def charts_medium_bubble_demo
        #     bubble_series = (1..4).map do |n|{name: "Bubble#{n}",data: 20.times.map{[rand(750),rand(10..60),rand(70)]}}end
        #     bubble_chart(bubble_series, data_labels: false, theme: 'palette6')
        # end

        # def charts_medium_range_demo
        #     range_bar_series = [{name: "Series A",data: {'A' => [1, 5],'B' => [4, 6],'C' => [5, 8],'D' => [3, 11]}}, {name: "Series B",data: {'A' => [2, 6],'B' => [1, 3],'C' => [7, 8],'D' => [5, 9]}}]
        #     range_bar_chart(range_bar_series, theme: 'palette3')
        # end
    end
end

ActiveSupport.on_load(:action_view) { include Helpers::ChartsHelper }