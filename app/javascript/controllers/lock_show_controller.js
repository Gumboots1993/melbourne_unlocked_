import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
        // 💚 success callback, mandatory
        function success(position) {
        // target the element containing the location data
        let elUnlocked = document.querySelector('.unlocked');
        let elLocked = document.querySelector('.locked');
        let elLockedClose = document.querySelector('.locked-close');
        // get the data from the attribute
        let unlocked = elUnlocked.getAttribute('data-unlocked');
        let lat = elLocked.getAttribute('data-lat')
        let lng = elLocked.getAttribute('data-lng')
        let distance = 0
          // set points
          let from = turf.point([position.coords.latitude, position.coords.longitude]);
          let to = turf.point([lat, lng]);
          //set option for turf calc
          let options = {units: "kilometers"};
          // turf distance calculation
          distance = turf.distance(from, to, options);

          if (unlocked === "true") {
            elLocked.remove();
            elLockedClose.remove();
          } else if(distance > 0.05) {
            elLockedClose.remove();
            elUnlocked.remove();
          } else {
            elLocked.remove();
            elUnlocked.remove();
          }
        }
        // 🚨 error callback, optional
        function error (err) {
          // display error
          console.log(err);
        }
        // options, optional
        const options = {
          timeout: 5000,
          maximumAge: Infinity
        }

      // 🚀 get user's currnt position
      navigator.geolocation.getCurrentPosition(success, error, options);


  }
}
