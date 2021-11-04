function initMap() {
    // Latitude and Longitude
    var myLatLng = {lat: 41.330900, lng: 1.922423};

    var map = new google.maps.Map(document.getElementById('google-maps'), {
        zoom: 12,
        center: myLatLng
    });

    var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: 'Begues, Spain' // Title Location
    });
}