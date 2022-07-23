import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
        // 💚 success callback, mandatory
        function success(position) {
        // target the element containing the location data
        var elUnlocked = document.querySelector('.unlocked');
        var elLocked = document.querySelector('.locked');
        var elLockedClose = document.querySelector('.locked-close');
        // get the data from the attribute
        var unlocked = elUnlocked.getAttribute('data-unlocked');
        var lat = elLocked.getAttribute('data-lat')
        var lng = elLocked.getAttribute('data-lng')
        var distance = 0
          // set points
          var from = turf.point([position.coords.latitude, position.coords.longitude]);
          var to = turf.point([lat, lng]);
          //set option for turf calc
          var options = {units: "kilometers"};
          // turf distance calculation
          distance = turf.distance(from, to, options);

          if (unlocked === "true") {
            elLocked.remove();
            elLockedClose.remove();
          } else if(distance > 0.6) {
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
