$.fn.qtip.defaults.style.classes = 'ui-tooltip-bootstrap'
$.fn.qtip.defaults.style.def = false

housing_data = {}
map = null
colour_scale = null

# tooltip = (d) ->
#   pop = numeral(get_pop(d)).format('0.0a')
#   growth = numeral(get_growth(d)).format('0.00%')
#   "Current population: #{pop} <br>Forecast growth: #{growth}"

get_price = (zip) ->
  year = $('#inputYear').val()
  bclass = $('#inputClass').val()

  if bclass == 'Condos'
    bclass = 'CONDOS - ELEVATOR APARTMENTS'
  else
    bclass = 'COOPS - ELEVATOR APARTMENTS'

  return housing_data[bclass][year][zip]

show_map = (map_svg) ->

  # Map sizing
  map = kartograph.map($('#map'))

  map.setMap map_svg

  console.log 'Loading map'

  map.addLayer 'zipcodes',
    styles:
      fill: (d) ->
        return colour_scale get_price d.postal
    tooltips: (d) ->
      [
        d.postal,
        get_price d.postal
      ]
    click: (d, path, event) ->
      console.log "Showing data for zip #{d.postal}"

  # TODO fixme
  # map.addLayer 'neighbourhoods',
  #   styles:
  #     fill: '#ff0'
  #     # 'stroke-width': 0.5

  # map.addLayer 'schools',
  #   styles:
  #     'stroke-width': 0.5

  $('.loading').remove()

  $(window).on 'resize', ->
    map.resize()

redraw_map = ->
  console.log 'redraw'
  layer = map.getLayer 'zipcodes'
  layer.style
    fill: (d) ->
      return colour_scale get_price d.postal

$.getJSON 'prices.json', (prices) ->

  console.log prices
  colour_scale = chroma.scale('YlOrRd').domain(prices.prices, 10, 'quantiles')

  $.getJSON 'predictions.json', (predictions) ->

    housing_data = predictions

    $.get 'manhattan.svg', (svg) ->
      show_map(svg)

      $('#inputYear').on 'change', ->
        redraw_map()
      $('#inputClass').on 'change', ->
        redraw_map()
