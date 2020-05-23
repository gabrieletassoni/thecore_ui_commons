require 'date'
module Helpers
    module ChartsHelper
        def candlestick_data
            @acc = rand(6570..6650)
            60.times.map {|i| [Date.today - 60 + i, ohlc] }.to_h
        end
        
        def ohlc
            open = @acc + rand(-20..20)
            high = open + rand(0..100)
            low = open - rand(0..100)
            @acc = close = open + rand(-((high-low)/3)..((high-low)/2))
            [open, high, low, close]
        end
    end
end