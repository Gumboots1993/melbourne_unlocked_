import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this._addMarkersToMap()
    this._fitMapToMarkers()

    this.map.addControl(new mapboxgl.NavigationControl());
    this.map.addControl(
      new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true
      },
      // When active the map will receive updates to the device's location as it changes.
      trackUserLocation: true,
      // Draw an arrow next to the location dot to indicate which direction the device is heading.
      showUserHeading: true
      })
      );
  }

  _addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      if (!navigator.geolocation) {
        alert("Geolocation is not supported in this browser.");
      } else {
        // 🚀 get user's currnt position
        navigator.geolocation.watchPosition(
          // 💚 success callback, mandatory
          (position) => {
            // target the element containing the location data
            // var el = document.querySelector('.span');
            // get the data from the attribute
            // var long = el.getAttribute('data-lon')
            // var lat = el.getAttribute('data-lat')
            // set points
            var from = turf.point([position.coords.latitude, position.coords.longitude]);
            var to = turf.point([marker.lat, marker.lng]);
            //set option for turf calc
            var options = {units: "kilometers"};
            // turf distance calculation
            var distance = turf.distance(from, to, options);

            console.log(distance);
            const popup = new mapboxgl.Popup().setHTML(marker.info_window)
          // const customPopup = document.createElement("div")
          // customPopup.className = "popupp"
          // popupp.style.borderRadius = "5%"

          const customMarker = document.createElement("div")
          customMarker.className = "marker"
          if (distance > 0.6) {
            customMarker.style.backgroundImage = `url('https://media-cldnry.s-nbcnews.com/image/upload/newscms/2016_14/1038581/red-dot-puzzle-before-today-160406.jpg')`
          } else {
            customMarker.style.backgroundImage = `url('https://miro.medium.com/max/1024/1*nZ9VwHTLxAfNCuCjYAkajg.png')`
          }
          customMarker.style.backgroundSize = "cover"
          customMarker.style.width = "25px"
          customMarker.style.height = "25px"
          customMarker.style.borderRadius = "50%"
          customMarker.style.cursor = "pointer"

          new mapboxgl.Marker(customMarker)
            .setLngLat([ marker.lng, marker.lat ])
            .setPopup(popup)
            .addTo(this.map)
          },
          // 🚨 error callback, optional
          (error) => {
            // display error
            console.log(error);
          },
        );


      }
    });
  }

  _fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 30, maxZoom: 13, duration: 0 })
  }
}
