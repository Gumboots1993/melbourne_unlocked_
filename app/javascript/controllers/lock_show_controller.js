import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
        // 💚 success callback, mandatory
        function success(position) {
        // target the element containing the location data
        const elUnlocked = document.querySelector('.unlocked');
        const elLocked = document.querySelector('.locked');
        const elLockedClose = document.querySelector('.locked-close');
        const mapUnlocked = document.querySelector('.map-unlocked');
        const mapLocked = document.querySelector('.map-locked');
        const mapUnlockable = document.querySelector('.map-unlockable');
        // get the data from the attribute
        const unlocked = elUnlocked.getAttribute('data-unlocked');
        const lat = elLocked.getAttribute('data-lat')
        const lng = elLocked.getAttribute('data-lng')
        let distance = 0
          // set points
          const from = turf.point([position.coords.latitude, position.coords.longitude]);
          const to = turf.point([lat, lng]);
          //set option for turf calc
          const options = {units: "kilometers"};
          // turf distance calculation
          distance = turf.distance(from, to, options);

          if (unlocked === "true") {
            elLocked.remove();
            elLockedClose.remove();
            mapLocked.remove();
            mapUnlockable.remove();
          } else if(distance > 0.09) {
            elLockedClose.remove();
            elUnlocked.remove();
            mapUnlocked.remove();
            mapUnlockable.remove();
          } else {
            elLocked.remove();
            elUnlocked.remove();
            mapLocked.remove();
            mapUnlocked.remove();
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
