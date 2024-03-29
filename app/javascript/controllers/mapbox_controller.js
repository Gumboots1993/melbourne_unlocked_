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
      style: "mapbox://styles/gumboots1993/cl6di65to000i15kbxv4thsj0",
      center: [144.963178, -37.814248],
      zoom: 14
    })

    this._addMarkersToMap()
    // this._fitMapToMarkers()
    // this._addBuildingsToMap()
    const nav = new mapboxgl.NavigationControl({
      visualizePitch: true,
      showCompass: true,
      showZoom: false
    });

    // if (window.location.pathname === '/') {
    this.map.addControl(nav, 'bottom-right');
    // }

    const geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true,
      maximumAge: Infinity
      },
      // When active the map will receive updates to the device's location as it changes.
      trackUserLocation: true,
      // Draw an arrow next to the location dot to indicate which direction the device is heading.
      showUserHeading: true,
      showAccuracyCircle: false
      })
      // if (window.location.pathname === '/') {
        this.map.addControl(geolocate, 'bottom-right');
        this.map.on('load', () => {
          geolocate.trigger();
        })
      // }
  }

  _addMarkersToMap() {

    var options = {};
      // 🚀 get user's currnt position
     navigator.geolocation.getCurrentPosition(
      // 💚 success callback, mandatory
      (position) => {
        this.markersValue.forEach((marker) => {
        // set points
        const from = turf.point([position.coords.latitude, position.coords.longitude]);
        const to = turf.point([marker.lat, marker.lng]);
        //set option for turf calc
        const options = {units: "kilometers"};
        // turf distance calculation
        const distance = turf.distance(from, to, options);

          const popup = new mapboxgl.Popup({anchor: 'center'})
            // .setHTML(marker.info_window)
            .setLngLat([ marker.lng, marker.lat ])
            .setMaxWidth('75vw');
          const customMarker = document.createElement("div")
          customMarker.className = "marker"
          if (marker.image_url != "") {
            customMarker.setAttribute('data-unlocked', true)
            customMarker.style.backgroundImage = "url('/assets/unlocked_2.svg')";
          } else if (distance > 0.15) {
            customMarker.setAttribute('data-unlocked', false)
            customMarker.style.backgroundImage = "url('/assets/locked_1.svg')";
          } else {
            customMarker.setAttribute('data-unlocked', false)
            customMarker.style.backgroundImage = "url('/assets/unlockable_2.svg')";
          }
          customMarker.setAttribute('data-lat', marker.lat)
          customMarker.setAttribute('data-lng', marker.lng)
          customMarker.setAttribute('data-controller', 'marker')
          customMarker.style.backgroundSize = "cover"
          customMarker.style.width = "25px"
          customMarker.style.height = "25px"
          customMarker.style.borderRadius = "50%"
          customMarker.style.cursor = "pointer"
          new mapboxgl.Marker(customMarker)
            .setLngLat([ marker.lng, marker.lat ])
            .setPopup(popup)
            .addTo(this.map)
          popup.on('open', () => {
            this.map.flyTo({center: [ marker.lng, marker.lat ], zoom: 15});;
            });
          popup.on('open', () => {
            popup.setHTML(marker.info_window);
          } )
        });

      },
      // 🚨 error callback, optional
      (error) => {
        // display error
        console.log(error);
        this.markersValue.forEach((marker) => {
          const popup = new mapboxgl.Popup({anchor: 'center'})
          // .setHTML(marker.info_window)
          .setLngLat([ marker.lng, marker.lat ])
          .setMaxWidth('75vw');
        const customMarker = document.createElement("div")
        customMarker.className = "marker"
        if (marker.image_url != "") {
          customMarker.setAttribute('data-unlocked', true)
          customMarker.style.backgroundImage = "url('/assets/unlocked_2.svg')";
        } else {
          customMarker.setAttribute('data-unlocked', false)
          customMarker.style.backgroundImage = "url('/assets/locked_1.svg')";
        }
        customMarker.setAttribute('data-lat', marker.lat)
        customMarker.setAttribute('data-lng', marker.lng)
        customMarker.setAttribute('data-controller', 'marker')
        customMarker.style.backgroundSize = "cover"
        customMarker.style.width = "25px"
        customMarker.style.height = "25px"
        customMarker.style.borderRadius = "50%"
        customMarker.style.cursor = "pointer"
        new mapboxgl.Marker(customMarker)
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup)
          .addTo(this.map)
        popup.on('open', () => {
          this.map.flyTo({center: [ marker.lng, marker.lat ], zoom: 15});;
          });
        popup.on('open', () => {
          popup.setHTML(marker.info_window);
        } )
        });
      },
      options = {
        maximumAge: Infinity
      }
    );

  }

  _fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 30, maxZoom: 13, duration: 0 })
  }
}
