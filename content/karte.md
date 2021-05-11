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

    const i_phone = "<i class=\"fas fa-phone\"></i>";
    function phone_link(tel) {
        return `<a href="tel:${tel.replaceAll(' ', '')}">${tel}</a>`;
    }
    function phone(tel) {
        return i_phone + " " + phone_link(tel);
    }
    const i_globe = "<i class=\"fas fa-globe\"></i>";
    function website(url) {
        return `${i_globe} <a href=\"${url}\">${url}</a>`;
    }
    const i_envelope = '<i class="far fa-envelope"></i>';
    function email(mail) {
        return `${i_envelope} <a href=\"mailto:${mail}\">${mail}</a>`;
    }
    const iz_tel = phone("0611 505 92 888") + " oder " + phone_link("116 117");
    const iz_url = website("http://impfterminservice.hessen.de/");
    const registration = `<b>Anmeldung</b><br>${iz_url}<br>${iz_tel}`;

    fetch(request)
    .then(function(response) { return response.json(); })
    .then(function(data) {
        for (var i = 0; i < data.records.length; i++) {
            let record = data.records[i].fields;
            var marker = L.marker([record.lat, record.lon]).addTo(map);

            let street = record['addr:street'];
            let housenumber = record['addr:housenumber'];
            let address1 = street ? (housenumber ? `${street} ${housenumber}` : street) : "<i>Genaue Adresse unbekannt</i>";
            let list = [`<b>${record.name}</b>`, address1, record.city, "", registration];
            if (record['tel'] || record['email']) {
                list.push('');
                list.push('<b>Kontakt</b>');
                if (record['email']) list.push(email(record['email']));
                if (record['tel']) {
                    list.push(phone(record['tel']));
                    if (record['tel:time']) list.push(record['tel:time']);
                }
            }
            marker.bindPopup(list.join('<br>'));
        }
    });
</script>


