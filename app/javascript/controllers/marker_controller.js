import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
        // 💚 success callback, mandatory
        function success(position) {
        // target the element containing the location data
        let allMarkers = document.querySelectorAll('div.marker');
        allMarkers.forEach((marker => {
          // get the data from the attribute
          let unlocked = marker.getAttribute('data-unlocked');
          let lat = marker.getAttribute('data-lat')
          let lng = marker.getAttribute('data-lng')
          let distance = 0
          // set points
          let from = turf.point([position.coords.latitude, position.coords.longitude]);
          let to = turf.point([lat, lng]);
          //set option for turf calc
          let options = {units: "kilometers"};
          // turf distance calculation
          distance = turf.distance(from, to, options);

          if (unlocked === "true") {
            marker.style.backgroundImage = "url('assets/unlocked_2.svg')";
          } else if(distance > 0.05) {
            marker.style.backgroundImage = "url('assets/locked_1.svg')";

          } else {
            marker.style.backgroundImage = "url('assets/unlockable_1.svg')";

          }
        }));
        }
        // 🚨 error callback, optional
        function error (err) {
          // display error
          console.log(err);
        }
        // options, optional
        const options = {
          maximumAge: Infinity
        }

      // 🚀 get user's currnt position
      navigator.geolocation.watchPosition(success, error, options);


  }
}
