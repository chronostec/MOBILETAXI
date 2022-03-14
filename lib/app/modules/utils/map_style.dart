const String mapStyle = '[ { "featureType": "administrative", "elementType": "all", ' +
    '"stylers": [ { "visibility": "on" }, { "lightness": 33 } ] }, ' +
    '{ "featureType": "administrative.country", "elementType": "geometry.fill",' +
    ' "stylers": [ { "visibility": "off" } ] }, ' +
    '{ "featureType": "administrative.country", "elementType": "labels.text",' +
    ' "stylers": [ { "visibility": "off" } ] }, { "featureType":' +
    ' "administrative.land_parcel", "elementType": "all", "stylers": ' +
    '[ { "visibility": "off" } ] }, { "featureType": "landscape", "elementType":' +
    ' "all", "stylers": [ { "color": "#f2e5d4" }, { "visibility": "simplified" } ] },' +
    ' { "featureType": "poi", "elementType": "all", "stylers": [ { "visibility":' +
    ' "simplified" } ] }, { "featureType": "poi.attraction", "elementType": "all", ' +
    '"stylers": [ { "visibility": "simplified" } ] }, { "featureType": "poi.business",' +
    ' "elementType": "all", "stylers": [ { "visibility": "off" } ] }, { "featureType":' +
    ' "poi.government", "elementType": "all", "stylers": [ { "visibility": ' +
    '"simplified" } ] }, { "featureType": "poi.government", "elementType": "geometry", ' +
    '"stylers": [ { "visibility": "off" } ] }, { "featureType": "poi.medical", "elementType":' +
    ' "all", "stylers": [ { "visibility": "simplified" } ] }, { "featureType": "poi.park",' +
    ' "elementType": "all", "stylers": [ { "visibility": "simplified" } ] },' +
    ' { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#c5dac6" } ] }, { "featureType": ' +
    '"poi.park", "elementType": "labels", "stylers": [ { "visibility": "on" },' +
    ' { "lightness": 20 } ] }, { "featureType": "poi.place_of_worship",' +
    ' "elementType": "all", "stylers": [ { "visibility": "simplified" } ] },' +
    ' { "featureType": "poi.school", "elementType": "all", "stylers": [ { "visibility": "simplified" }' +
    ' ] }, { "featureType": "poi.sports_complex", "elementType": "all", "stylers": [' +
    ' { "visibility": "simplified" } ] }, { "featureType": "road", "elementType": "all", "stylers":' +
    ' [ { "lightness": 20 }, { "visibility": "on" } ] }, { "featureType": "road.highway",' +
    ' "elementType": "geometry", "stylers": [ { "color": "#c5c6c6" } ] }, { "featureType": "road.arterial",' +
    ' "elementType": "geometry", "stylers": [ { "color": "#e4d7c6" } ] }, ' +
    '{ "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#fbfaf7" } ] }, ' +
    '{ "featureType": "transit", "elementType": "all",' +
    ' "stylers": [ { "visibility": "simplified" } ] }, { "featureType": ' +
    '"transit.station", "elementType": "all", "stylers": [ { "visibility":' +
    ' "simplified" } ] }, { "featureType": "water", "elementType": "all",' +
    ' "stylers": [ { "visibility": "simplified" }, { "color": "#acbcc9" } ] } ]';

const String clientstyle =
    '[ { "featureType": "landscape", "elementType": "all", "stylers": [ { "hue": "#6600ff" }, { "saturation": "-16" }, { "visibility": "on" } ] }, { "featureType": "landscape.man_made", "elementType": "all", "stylers": [ { "visibility": "off" }, { "saturation": "0" }, { "gamma": "0.7" } ] }, { "featureType": "landscape.man_made", "elementType": "labels", "stylers": [ { "visibility": "off" } ] }, { "featureType": "landscape.man_made", "elementType": "labels.text", "stylers": [ { "visibility": "off" } ] }, { "featureType": "landscape.man_made", "elementType": "labels.icon", "stylers": [ { "visibility": "on" } ] }, { "featureType": "poi", "elementType": "all", "stylers": [ { "saturation": "27" }, { "hue": "#3200ff" }, { "lightness": "3" }, { "visibility": "off" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "visibility": "off" } ] }, { "featureType": "poi", "elementType": "geometry.stroke", "stylers": [ { "visibility": "on" }, { "weight": "1.00" } ] }, { "featureType": "poi", "elementType": "labels", "stylers": [ { "visibility": "off" } ] }, { "featureType": "poi", "elementType": "labels.text.stroke", "stylers": [ { "weight": "0.01" } ] }, { "featureType": "poi", "elementType": "labels.icon", "stylers": [ { "weight": "0.01" }, { "visibility": "off" } ] }, { "featureType": "poi.attraction", "elementType": "all", "stylers": [ { "saturation": "-58" }, { "lightness": "28" }, { "visibility": "off" } ] }, { "featureType": "poi.business", "elementType": "all", "stylers": [ { "saturation": "-31" }, { "lightness": "7" }, { "gamma": "1" }, { "weight": "0.01" } ] }, { "featureType": "poi.business", "elementType": "geometry", "stylers": [ { "visibility": "off" }, { "gamma": "1" } ] }, { "featureType": "poi.business", "elementType": "geometry.fill", "stylers": [ { "gamma": "1" } ] }, { "featureType": "poi.business", "elementType": "geometry.stroke", "stylers": [ { "weight": "1" } ] }, { "featureType": "poi.business", "elementType": "labels.text.stroke", "stylers": [ { "weight": "0.01" }, { "gamma": "1" }, { "lightness": "0" }, { "saturation": "0" } ] }, { "featureType": "poi.business", "elementType": "labels.icon", "stylers": [ { "visibility": "on" }, { "weight": "0.01" } ] }, { "featureType": "poi.government", "elementType": "all", "stylers": [ { "saturation": "-58" }, { "lightness": "28" }, { "visibility": "off" } ] }, { "featureType": "poi.medical", "elementType": "all", "stylers": [ { "saturation": "-58" }, { "lightness": "28" }, { "visibility": "off" } ] }, { "featureType": "poi.park", "elementType": "all", "stylers": [ { "visibility": "off" }, { "saturation": "-58" }, { "lightness": "28" } ] }, { "featureType": "poi.place_of_worship", "elementType": "all", "stylers": [ { "saturation": "-58" }, { "lightness": "28" }, { "visibility": "on" } ] }, { "featureType": "poi.school", "elementType": "all", "stylers": [ { "saturation": "-58" }, { "lightness": "28" }, { "visibility": "off" } ] }, { "featureType": "poi.sports_complex", "elementType": "all", "stylers": [ { "saturation": "-58" }, { "lightness": "28" }, { "visibility": "off" } ] }, { "featureType": "road", "elementType": "all", "stylers": [ { "hue": "#6600ff" }, { "saturation": "-57" }, { "lightness": "-28" } ] }, { "featureType": "road", "elementType": "labels.text", "stylers": [ { "lightness": "-100" }, { "saturation": "10" }, { "color": "#ffffff" } ] }, { "featureType": "road", "elementType": "labels.text.fill", "stylers": [ { "saturation": "0" } ] }, { "featureType": "road", "elementType": "labels.text.stroke", "stylers": [ { "lightness": "100" }, { "saturation": "100" }, { "weight": "0.01" } ] }, { "featureType": "road.local", "elementType": "all", "stylers": [ { "lightness": "-45" }, { "weight": 1.3 }, { "color": "#6600ff" }, { "saturation": "-57" }, { "gamma": "2.35" }, { "visibility": "on" } ] }, { "featureType": "road.local", "elementType": "labels", "stylers": [ { "visibility": "on" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "visibility": "simplified" }, { "hue": "#5e00ff" }, { "saturation": -16 } ] }, { "featureType": "transit.line", "elementType": "all", "stylers": [ { "saturation": -72 } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "saturation": -65 }, { "hue": "#1900ff" }, { "lightness": 8 }, { "visibility": "on" } ] } ]';
