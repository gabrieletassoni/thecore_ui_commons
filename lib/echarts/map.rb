module Echarts
  module Map
    def self.get_config coordinates, title
      # coordinates is an array of two elements arrays, each element is a coordinate in lat, long format.
      # Example: [[lat1, long1, injested_at], [lat2, long2, injested_at], ...]
      # Create the lines array, which is an array of objects with the coordinates of the start and end of the line, and with label the injested_at value
      lines = coordinates.each_cons(2).map do |(start, finish)|
        {
          coords: [start[0..1], finish[0..1]],
          lineStyle: {
            color: 'purple',
            opacity: 0.6,
            width: 1
          },
          label: {
            show: true,
            formatter: finish[2]
          }
        }
      end

      {
        backgroundColor: 'transparent',
        bmap: {
          center: [120.13066322374, 30.240018034923],
          zoom: 14,
          roam: true,
          mapStyle: {
            styleJson: [
              {
                featureType: 'water',
                elementType: 'all',
                stylers: {
                  color: '#d1d1d1'
                }
              },
              {
                featureType: 'land',
                elementType: 'all',
                stylers: {
                  color: '#f3f3f3'
                }
              },
              {
                featureType: 'railway',
                elementType: 'all',
                stylers: {
                  visibility: 'off'
                }
              },
              {
                featureType: 'highway',
                elementType: 'all',
                stylers: {
                  color: '#fdfdfd'
                }
              },
              {
                featureType: 'highway',
                elementType: 'labels',
                stylers: {
                  visibility: 'off'
                }
              },
              {
                featureType: 'arterial',
                elementType: 'geometry',
                stylers: {
                  color: '#fefefe'
                }
              },
              {
                featureType: 'arterial',
                elementType: 'geometry.fill',
                stylers: {
                  color: '#fefefe'
                }
              },
              {
                featureType: 'poi',
                elementType: 'all',
                stylers: {
                  visibility: 'off'
                }
              },
              {
                featureType: 'green',
                elementType: 'all',
                stylers: {
                  visibility: 'off'
                }
              },
              {
                featureType: 'subway',
                elementType: 'all',
                stylers: {
                  visibility: 'off'
                }
              },
              {
                featureType: 'manmade',
                elementType: 'all',
                stylers: {
                  color: '#d1d1d1'
                }
              },
              {
                featureType: 'local',
                elementType: 'all',
                stylers: {
                  color: '#d1d1d1'
                }
              },
              {
                featureType: 'arterial',
                elementType: 'labels',
                stylers: {
                  visibility: 'off'
                }
              },
              {
                featureType: 'boundary',
                elementType: 'all',
                stylers: {
                  color: '#fefefe'
                }
              },
              {
                featureType: 'building',
                elementType: 'all',
                stylers: {
                  color: '#d1d1d1'
                }
              },
              {
                featureType: 'label',
                elementType: 'labels.text.fill',
                stylers: {
                  color: '#999999'
                }
              }
            ]
          }
        },
        series: [
          {
            type: 'lines',
            coordinateSystem: 'bmap',
            data: lines,
            polyline: true,
            lineStyle: {
              color: 'purple',
              opacity: 0.6,
              width: 1
            }
          }
        ]
      }
    end
  end
end