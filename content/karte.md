+++
title = "Karte"
template = "with-map.html"
weight = 1
+++

# Karte

Auf dieser Karte werde die Standorte der Impfstellen angezeigt.

<div id="map"></div>
<!--<p><a href="https://www.maptiler.com/copyright/" target="_blank">© MapTiler</a></p>-->

# Datenquellen

Um diese Karte zu generieren verwenden wir unter anderem die folgenden Datenquellen

## Staatliche Impfzentren

- OSM – <a href="https://www.openstreetmap.org/copyright" target="_blank">© OpenStreetMap contributors</a>
- Land Hessen: <https://corona-impfung.hessen.de/für-bürger/die-impfzentren>

<script>
    var map = L.map('map').setView([50.540,9], 7);
    var gl = L.mapboxGL({
    attribution: "\u003ca href=\"https://www.maptiler.com/copyright/\" target=\"_blank\"\u003e\u0026copy; MapTiler\u003c/a\u003e \u003ca href=\"https://www.openstreetmap.org/copyright\" target=\"_blank\"\u003e\u0026copy; OpenStreetMap contributors\u003c/a\u003e",
    style: 'https://api.maptiler.com/maps/339b74e3-736a-4a41-94e3-bafcc9dcffb7/style.json?key=g4rPvq9AptKIXPP2JxyE'
    }).addTo(map);

    var request = new Request('/impfzentren.json');

    fetch(request)
    .then(function(response) { return response.json(); })
    .then(function(data) {
        for (var i = 0; i < data.records.length; i++) {
        let record = data.records[i].fields;
        var marker = L.marker([record.lat, record.lon]).addTo(map);

        let street = record['addr:street'];
        let housenumber = record['addr:housenumber'];
        let address1 = street ? (housenumber ? `${street} ${housenumber}` : street) : "<i>Genaue Adresse unbekannt</i>";
        let tel_nr = "0611 505 92 888";
        let tel = `<b>Telefon</b>: <a href=\"tel:${tel_nr.replace(' ','')}\">${tel_nr}</a>`;
        let website_url = "http://impfterminservice.hessen.de/";
        let website = `<b>Website</b>: <a href=\"${website_url}\">${website_url}</a>`;
        marker.bindPopup(`<b>${record.name}</b><br>${address1}<br>${record.city}<br><br>${website}<br>${tel}`);
        }
    });
</script>


