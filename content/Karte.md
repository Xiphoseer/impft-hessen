+++
title = "Karte"
template = "with-map.html"
weight = 1
+++

# Karte

<div id="map"></div>
<!--<p><a href="https://www.maptiler.com/copyright/" target="_blank">© MapTiler</a>
<a href="https://www.openstreetmap.org/copyright" target="_blank">© OpenStreetMap contributors</a></p>-->

<script>
    var map = L.map('map').setView([50.540,8.0420], 8);
    var gl = L.mapboxGL({
    attribution: "\u003ca href=\"https://www.maptiler.com/copyright/\" target=\"_blank\"\u003e\u0026copy; MapTiler\u003c/a\u003e \u003ca href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\"\u003e\u0026copy; OpenStreetMap contributors\u003c/a\u003e",
    style: 'https://api.maptiler.com/maps/339b74e3-736a-4a41-94e3-bafcc9dcffb7/style.json?key=g4rPvq9AptKIXPP2JxyE'
    }).addTo(map);
</script>


