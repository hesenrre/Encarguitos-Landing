# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

$ ->

  enableMainButton = () ->
    $("#modalTrigger").click(()->
      $("#myModal").modal("show")
      $("#myModal").css("visibility", "visible")
    )
 
  writeAddrs = (lat, lng, addrsField, latField, lngField) ->
    geocoder = new google.maps.Geocoder()
    latLng = new google.maps.LatLng(lat, lng)
    geocoder.geocode({'latLng': latLng}, (results, status) ->
      if status == google.maps.GeocoderStatus.OK and results[1]
        $(addrsField).text(results[1].formatted_address)
        $(latField).val(lat)
        $(lngField).val(lng)
    )
    
  makeMap = (position)->
    console.debug(position.coords.latitude)
    options = 
      center: new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      zoom: 16
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map($("#map_canvas")[0], options)
    myLatlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

    marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title:"Hello World!",
      draggable:true,
      animation: google.maps.Animation.DROP
    })

    writeAddrs(position.coords.latitude, position.coords.longitude, "#order_addrs", "#order_lat", "#order_lng")
    
    google.maps.event.addListener(marker, "dragend", (event) ->
        writeAddrs(event.latLng.lat(), event.latLng.lng(), "#order_addrs", "#order_lat", "#order_lng")
    )

  initialize = () ->
    navigator.geolocation.getCurrentPosition(makeMap);
    enableMainButton()

  initialize()
