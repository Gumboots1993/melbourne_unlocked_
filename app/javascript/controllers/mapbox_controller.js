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
    console.log('markers added to map')
    this._fitMapToMarkers()
    console.log('markers fitted to map')
    this.map.addControl(new mapboxgl.NavigationControl());
    this.map.addControl(
      new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true,
      maximumAge: Infinity
      },
      // When active the map will receive updates to the device's location as it changes.
      trackUserLocation: true,
      // Draw an arrow next to the location dot to indicate which direction the device is heading.
      showUserHeading: true
      })
      );
  }

  _addMarkersToMap() {

    let options = {};
      // 🚀 get user's currnt position
     navigator.geolocation.getCurrentPosition(
      // 💚 success callback, mandatory
      (position) => {
        // var removeMarkers = document.querySelectorAll("div.marker")
        // removeMarkers.forEach((mark => { mark.remove();}));
        // console.log('markers removed')
        this.markersValue.forEach((marker) => {
        // set points
        var from = turf.point([position.coords.latitude, position.coords.longitude]);
        var to = turf.point([marker.lat, marker.lng]);
        //set option for turf calc
        var options = {units: "kilometers"};
        // turf distance calculation
        var distance = turf.distance(from, to, options);
        console.log(distance);
          const popup = new mapboxgl.Popup({anchor: 'center'})
            // .setHTML(marker.info_window)
            .setLngLat([ marker.lng, marker.lat ])
            .setMaxWidth('50');
          // const customPopup = document.createElement("div")
          // customPopup.className = "popupp"
          // popupp.style.borderRadius = "5%"
          const customMarker = document.createElement("div")
          customMarker.className = "marker"
          if (marker.image_url != "") {
            customMarker.setAttribute('data-unlocked', true)
            customMarker.style.backgroundImage = `url("data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg id='Layer_2' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 76.11 76.11'%3E%3Cdefs%3E%3Cstyle%3E.cls-1,.cls-2%7Bfill:%23fff;%7D.cls-3%7Bfill:%23085b56;%7D.cls-4%7Bfill:url(%23Orange__Yellow-2);%7D.cls-5%7Bfill:%23d4e7e5;%7D.cls-6%7Bfill:%2300a79d;%7D.cls-7%7Bfill:url(%23linear-gradient);%7D.cls-2%7Bstroke:url(%23Orange__Yellow);stroke-miterlimit:10;stroke-width:6px;%7D%3C/style%3E%3ClinearGradient id='Orange__Yellow' x1='0' y1='38.06' x2='76.11' y2='38.06' gradientTransform='matrix(1, 0, 0, 1, 0, 0)' gradientUnits='userSpaceOnUse'%3E%3Cstop offset='0' stop-color='%23fff33b'/%3E%3Cstop offset='.04' stop-color='%23fee62d'/%3E%3Cstop offset='.12' stop-color='%23fdd51b'/%3E%3Cstop offset='.2' stop-color='%23fdca0f'/%3E%3Cstop offset='.28' stop-color='%23fdc70c'/%3E%3Cstop offset='.67' stop-color='%23f3903f'/%3E%3Cstop offset='.89' stop-color='%23ed683c'/%3E%3Cstop offset='1' stop-color='%23e93e3a'/%3E%3C/linearGradient%3E%3ClinearGradient id='Orange__Yellow-2' x1='18.64' y1='50.8' x2='56.77' y2='50.8' xlink:href='%23Orange__Yellow'/%3E%3ClinearGradient id='linear-gradient' x1='38.07' y1='35.06' x2='38.07' y2='46.78' gradientTransform='matrix(1, 0, 0, 1, 0, 0)' gradientUnits='userSpaceOnUse'%3E%3Cstop offset='0' stop-color='%23fff33b'/%3E%3Cstop offset='.04' stop-color='%23fee62d'/%3E%3Cstop offset='.12' stop-color='%23fdd51b'/%3E%3Cstop offset='.2' stop-color='%23fdca0f'/%3E%3Cstop offset='.28' stop-color='%23fdc70c'/%3E%3Cstop offset='.67' stop-color='%23f3903f'/%3E%3Cstop offset='.84' stop-color='%23ed683c'/%3E%3Cstop offset='.96' stop-color='%23c54c29'/%3E%3C/linearGradient%3E%3C/defs%3E%3Cg id='Layer_1-2'%3E%3Ccircle class='cls-2' cx='38.06' cy='38.06' r='35.06'/%3E%3Cpath class='cls-4' d='M41.39,66.16c-2.8,.51-4.28,.43-7.37,0-3.83-.53-11.61-4.12-13.78-8.05l-1.6-17.59s.06-.04,.07-.15c.56-4.03,3.64-5.54,3.37-5.25-2.63,2.78-.22,4.67-.16,4.74,3.44,4.17,11.17,2.34,16.73-.57s14.96-6.88,18.13,.74c.01,.03,0,0,0,0l-1.6,18.08c-2.15,4.18-9.98,7.36-13.78,8.05Z'/%3E%3Cellipse class='cls-3' cx='37.77' cy='52.4' rx='2.59' ry='2.63'/%3E%3Cpolygon class='cls-3' points='36.11 54.24 39.09 54.24 40.04 59.8 35.28 59.8 36.11 54.24'/%3E%3Cpath class='cls-7' d='M21.25,41.97c-1.47-1.13-2.24-2.19-1.71-3.99,.2-.7,.61-1.42,1.04-1.89,.62-.69,1.66-1.15,1.52-1-.71,.77-.81,1.06-1,1.45-.33,.68-.32,1.47-.02,2.03,2.36,4.44,11.67,4.48,17.72,.72,6.49-4.03,15.36-6.21,17.97,.74,.01,.03-.02,.14-.03,.16-.36,.46-.83,1.13-1.85,1.66-6.92,3.59-22.13,8.94-33.63,.11Z'/%3E%3Cpath class='cls-6' d='M52.24,30.15h-1.88c-1.45-.41-1.3-1.85-1.3-3.14v-3.64c-.06-2.45-.44-3.6-1.26-3.67-1.49-.14-1.63,1.62-2.45,5.25-1.26,5.58-9.93,6.92-12.93,1.04l-.1-.18c-1.4-2.45-.25-5.7-2.66-5.49-1.65,.14-1.39,3.25-1.51,4.72,0,.13-.02,.26-.02,.39l-.04,11.41c-.28,1.68,.14,2.94-2.08,2.88,0,0-.91-.38-1.22-.48-1.51-.5-1.9-1.54-1.9-2.4v-15.19c0-2.61-.18-5.98,1.44-7.6,1.99-1.98,5.65-2.44,8.13-1.36l.11,.05c.36,.16,.71,.38,1,.66,4.04,4.08,2.33,10.39,5.18,10.52,2.83,.14,1.56-7.75,6.69-11.1h0c2.78-1.31,6.05-.61,8.08,1.88,1.27,1.57,.84,4.66,.84,6.93v6.19c0,1.29-.94,2.34-2.1,2.34Z'/%3E%3Cpath class='cls-1' d='M27.99,18.93l.73-.43v.02c-1.2,1.45-1.44,1.47-1.61,4.92v14.38c0,.12-.13,.13-.28,.09h0c-.3-.05-.51-.26-.51-.5v-14.74c0-.78,.13-1.56,.4-2.31h0c.2-.58,.66-1.08,1.27-1.44Z'/%3E%3Cpath class='cls-1' d='M52.18,13.97l.26,.37c.86,1.23,1.34,1.85,1.34,3.59v10.36h0c0,.39-.36,.93-.8,1.1v-9.26c0-3.98-.12-4.68-.73-5.89l-.07-.28Z'/%3E%3Cpath class='cls-5' d='M43.34,15.34c-.1,.3-.62,1.36-1.05,3.22l-1.17,3.95c-.41,1.31-1.25,2.05-2.41,2.81h0c1.67-.14,3.06-1.3,3.47-2.89l.7-2.38c.32-2.04,0-3.68,.46-4.71Z'/%3E%3Cellipse class='cls-3' cx='50.09' cy='38.9' rx='3.04' ry='.97'/%3E%3C/g%3E%3C/svg%3E")`
          } else if (distance > 0.6) {
            customMarker.setAttribute('data-unlocked', false)
            // customMarker.style.backgroundImage = `url("data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg id='Layer_2' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 76.11 76.11'%3E%3Cdefs%3E%3Cstyle%3E.cls-1,.cls-2%7Bfill:%23fff;%7D.cls-3%7Bfill:%23085b56;%7D.cls-4%7Bfill:url(%23Orange__Yellow-2);%7D.cls-5%7Bfill:%23d4e7e5;%7D.cls-6%7Bfill:%2300a79d;%7D.cls-7%7Bfill:url(%23linear-gradient);%7D.cls-2%7Bstroke:url(%23Orange__Yellow);stroke-miterlimit:10;stroke-width:6px;%7D%3C/style%3E%3ClinearGradient id='Orange__Yellow' x1='0' y1='38.06' x2='76.11' y2='38.06' gradientTransform='matrix(1, 0, 0, 1, 0, 0)' gradientUnits='userSpaceOnUse'%3E%3Cstop offset='0' stop-color='%23fff33b'/%3E%3Cstop offset='.04' stop-color='%23fee62d'/%3E%3Cstop offset='.12' stop-color='%23fdd51b'/%3E%3Cstop offset='.2' stop-color='%23fdca0f'/%3E%3Cstop offset='.28' stop-color='%23fdc70c'/%3E%3Cstop offset='.67' stop-color='%23f3903f'/%3E%3Cstop offset='.89' stop-color='%23ed683c'/%3E%3Cstop offset='1' stop-color='%23e93e3a'/%3E%3C/linearGradient%3E%3ClinearGradient id='Orange__Yellow-2' x1='18.64' y1='50.8' x2='56.77' y2='50.8' xlink:href='%23Orange__Yellow'/%3E%3ClinearGradient id='linear-gradient' x1='38.07' y1='35.06' x2='38.07' y2='46.78' gradientTransform='matrix(1, 0, 0, 1, 0, 0)' gradientUnits='userSpaceOnUse'%3E%3Cstop offset='0' stop-color='%23fff33b'/%3E%3Cstop offset='.04' stop-color='%23fee62d'/%3E%3Cstop offset='.12' stop-color='%23fdd51b'/%3E%3Cstop offset='.2' stop-color='%23fdca0f'/%3E%3Cstop offset='.28' stop-color='%23fdc70c'/%3E%3Cstop offset='.67' stop-color='%23f3903f'/%3E%3Cstop offset='.84' stop-color='%23ed683c'/%3E%3Cstop offset='.96' stop-color='%23c54c29'/%3E%3C/linearGradient%3E%3C/defs%3E%3Cg id='Layer_1-2'%3E%3Ccircle class='cls-2' cx='38.06' cy='38.06' r='35.06'/%3E%3Cpath class='cls-4' d='M41.39,66.16c-2.8,.51-4.28,.43-7.37,0-3.83-.53-11.61-4.12-13.78-8.05l-1.6-17.59s.06-.04,.07-.15c.56-4.03,3.64-5.54,3.37-5.25-2.63,2.78-.22,4.67-.16,4.74,3.44,4.17,11.17,2.34,16.73-.57s14.96-6.88,18.13,.74c.01,.03,0,0,0,0l-1.6,18.08c-2.15,4.18-9.98,7.36-13.78,8.05Z'/%3E%3Cellipse class='cls-3' cx='37.77' cy='52.4' rx='2.59' ry='2.63'/%3E%3Cpolygon class='cls-3' points='36.11 54.24 39.09 54.24 40.04 59.8 35.28 59.8 36.11 54.24'/%3E%3Cpath class='cls-7' d='M21.25,41.97c-1.47-1.13-2.24-2.19-1.71-3.99,.2-.7,.61-1.42,1.04-1.89,.62-.69,1.66-1.15,1.52-1-.71,.77-.81,1.06-1,1.45-.33,.68-.32,1.47-.02,2.03,2.36,4.44,11.67,4.48,17.72,.72,6.49-4.03,15.36-6.21,17.97,.74,.01,.03-.02,.14-.03,.16-.36,.46-.83,1.13-1.85,1.66-6.92,3.59-22.13,8.94-33.63,.11Z'/%3E%3Cpath class='cls-6' d='M52.24,30.15h-1.88c-1.45-.41-1.3-1.85-1.3-3.14v-3.64c-.06-2.45-.44-3.6-1.26-3.67-1.49-.14-1.63,1.62-2.45,5.25-1.26,5.58-9.93,6.92-12.93,1.04l-.1-.18c-1.4-2.45-.25-5.7-2.66-5.49-1.65,.14-1.39,3.25-1.51,4.72,0,.13-.02,.26-.02,.39l-.04,11.41c-.28,1.68,.14,2.94-2.08,2.88,0,0-.91-.38-1.22-.48-1.51-.5-1.9-1.54-1.9-2.4v-15.19c0-2.61-.18-5.98,1.44-7.6,1.99-1.98,5.65-2.44,8.13-1.36l.11,.05c.36,.16,.71,.38,1,.66,4.04,4.08,2.33,10.39,5.18,10.52,2.83,.14,1.56-7.75,6.69-11.1h0c2.78-1.31,6.05-.61,8.08,1.88,1.27,1.57,.84,4.66,.84,6.93v6.19c0,1.29-.94,2.34-2.1,2.34Z'/%3E%3Cpath class='cls-1' d='M27.99,18.93l.73-.43v.02c-1.2,1.45-1.44,1.47-1.61,4.92v14.38c0,.12-.13,.13-.28,.09h0c-.3-.05-.51-.26-.51-.5v-14.74c0-.78,.13-1.56,.4-2.31h0c.2-.58,.66-1.08,1.27-1.44Z'/%3E%3Cpath class='cls-1' d='M52.18,13.97l.26,.37c.86,1.23,1.34,1.85,1.34,3.59v10.36h0c0,.39-.36,.93-.8,1.1v-9.26c0-3.98-.12-4.68-.73-5.89l-.07-.28Z'/%3E%3Cpath class='cls-5' d='M43.34,15.34c-.1,.3-.62,1.36-1.05,3.22l-1.17,3.95c-.41,1.31-1.25,2.05-2.41,2.81h0c1.67-.14,3.06-1.3,3.47-2.89l.7-2.38c.32-2.04,0-3.68,.46-4.71Z'/%3E%3Cellipse class='cls-3' cx='50.09' cy='38.9' rx='3.04' ry='.97'/%3E%3C/g%3E%3C/svg%3E")`
            customMarker.style.backgroundImage = `url("data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg id='Layer_2' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 76.11 76.11'%3E%3Cdefs%3E%3Cstyle%3E.cls-1,.cls-2%7Bfill:%23fff;%7D.cls-3%7Bfill:%23a7a9ac;%7D.cls-2%7Bstroke:%239bc1be;stroke-miterlimit:10;stroke-width:6px;%7D.cls-4%7Bfill:%23808285;%7D.cls-5%7Bfill:%23d1d3d4;%7D.cls-6%7Bfill:%23231f20;%7D%3C/style%3E%3C/defs%3E%3Cg id='Layer_1-2'%3E%3Ccircle class='cls-2' cx='38.06' cy='38.06' r='35.06'/%3E%3Cg%3E%3Cpath class='cls-4' d='M42.47,61.33c-2.81,.51-4.31,.43-7.41,0-3.85-.53-11.69-4.14-13.87-8.1l-1.61-17.7s.06-.04,.07-.15c.56-4.06,3.67-5.58,3.39-5.28-2.65,2.8-.22,4.7-.17,4.77,3.46,4.2,11.24,2.36,16.83-.57,5.68-2.97,15.06-6.93,18.25,.75,.01,.03,0,0,0,0l-1.61,18.19c-2.16,4.2-10.05,7.4-13.87,8.1Z'/%3E%3Cellipse class='cls-6' cx='38.82' cy='47.49' rx='2.61' ry='2.65'/%3E%3Cpolygon class='cls-6' points='37.16 49.34 40.15 49.34 41.11 54.93 36.32 54.93 37.16 49.34'/%3E%3Cpath class='cls-3' d='M22.2,36.99c-1.48-1.14-2.25-2.2-1.73-4.01,.2-.7,.62-1.43,1.05-1.91,.62-.69,1.67-1.16,1.53-1-.71,.78-.81,1.07-1.01,1.46-.33,.69-.32,1.48-.02,2.05,2.38,4.47,11.74,4.51,17.84,.73,6.53-4.05,15.46-6.25,18.08,.75,.01,.03-.02,.14-.03,.17-.36,.47-.83,1.13-1.86,1.67-6.96,3.62-22.27,9-33.84,.11Z'/%3E%3Cpath class='cls-5' d='M53.38,35.23h-1.89c-1.46-.42-1.31-1.86-1.31-3.16v-3.67c-.06-2.46-.44-3.62-1.27-3.7-1.5-.14-1.64,1.63-2.47,5.29-1.27,5.62-10,6.97-13.01,1.04l-.1-.18c-1.41-2.46-.25-5.74-2.68-5.53-1.66,.14-1.4,3.27-1.52,4.75-.01,.13-.02,.26-.02,.39l-.04,1.62c-.28,1.69,.14,2.96-2.1,2.89,0,0-.92-.38-1.23-.49-1.51-.5-1.91-1.55-1.91-2.41v-5.43c0-2.63-.18-6.02,1.45-7.64,2-2,5.69-2.46,8.19-1.37l.11,.05c.37,.16,.72,.38,1,.67,4.06,4.1,2.35,10.45,5.21,10.59s1.57-7.8,6.73-11.17h0c2.8-1.32,6.09-.62,8.13,1.9,1.28,1.58,.85,4.69,.85,6.98v6.23c0,1.3-.95,2.35-2.11,2.35Z'/%3E%3Cpath class='cls-1' d='M28.98,24.65l.73-.21h-.01c-1.2,.71-1.43,.72-1.6,2.39v6.96c0,.06-.13,.06-.29,.04h0c-.3-.03-.52-.13-.52-.24v-7.14c0-.38,.14-.75,.4-1.12h0c.2-.28,.67-.52,1.28-.7Z'/%3E%3Cpath class='cls-1' d='M44.43,20.33c-.1,.3-.63,1.37-1.05,3.24l-1.18,3.97c-.42,1.32-1.26,2.06-2.42,2.83h0c1.68-.14,3.08-1.31,3.49-2.91l.71-2.4c.32-2.05,0-3.7,.46-4.74Z'/%3E%3Cpath class='cls-1' d='M53.1,18.92l.26,.37c.86,1.24,1.35,1.86,1.35,3.61v10.43h0c0,.39-.37,.94-.8,1.11v-9.32c0-4.01-.12-4.71-.73-5.92l-.07-.28Z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E")`
          } else {
            customMarker.setAttribute('data-unlocked', false)
            customMarker.style.backgroundImage = `url("data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg id='Layer_2' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 76.11 76.11'%3E%3Cdefs%3E%3Cstyle%3E.cls-1,.cls-2%7Bfill:%23fff;%7D.cls-3%7Bfill:%23085b56;%7D.cls-4%7Bfill:%239ac1be;%7D.cls-5%7Bfill:%2300a79d;%7D.cls-2%7Bstroke:%2300a79d;stroke-miterlimit:10;stroke-width:6px;%7D.cls-6%7Bfill:%23b6e1db;%7D%3C/style%3E%3C/defs%3E%3Cg id='Layer_1-2'%3E%3Ccircle class='cls-2' cx='38.06' cy='38.06' r='35.06'/%3E%3Cpath class='cls-5' d='M42.47,61.33c-2.81,.51-4.31,.43-7.41,0-3.85-.53-11.69-4.14-13.87-8.1l-1.61-17.7s.06-.04,.07-.15c.56-4.06,3.67-5.58,3.39-5.28-2.65,2.8-.22,4.7-.17,4.77,3.46,4.2,11.24,2.36,16.83-.57,5.68-2.97,15.06-6.93,18.25,.75,.01,.03,0,0,0,0l-1.61,18.19c-2.16,4.2-10.05,7.4-13.87,8.1Z'/%3E%3Cellipse class='cls-3' cx='38.82' cy='47.49' rx='2.61' ry='2.65'/%3E%3Cpolygon class='cls-3' points='37.16 49.34 40.15 49.34 41.11 54.93 36.32 54.93 37.16 49.34'/%3E%3Cpath class='cls-6' d='M22.2,36.99c-1.48-1.14-2.25-2.2-1.73-4.01,.2-.7,.62-1.43,1.05-1.91,.62-.69,1.67-1.16,1.53-1-.71,.78-.81,1.07-1.01,1.46-.33,.69-.32,1.48-.02,2.05,2.38,4.47,11.74,4.51,17.84,.73,6.53-4.05,15.46-6.25,18.08,.75,.01,.03-.02,.14-.03,.17-.36,.47-.83,1.13-1.86,1.67-6.96,3.62-22.27,9-33.84,.11Z'/%3E%3Cpath class='cls-4' d='M53.38,35.23h-1.89c-1.46-.42-1.31-1.86-1.31-3.16v-3.67c-.06-2.46-.44-3.62-1.27-3.7-1.5-.14-1.64,1.63-2.47,5.29-1.27,5.62-10,6.97-13.01,1.04l-.1-.18c-1.41-2.46-.25-5.74-2.68-5.53-1.66,.14-1.4,3.27-1.52,4.75-.01,.13-.02,.26-.02,.39l-.04,1.62c-.28,1.69,.14,2.96-2.1,2.89,0,0-.92-.38-1.23-.49-1.51-.5-1.91-1.55-1.91-2.41v-5.43c0-2.63-.18-6.02,1.45-7.64,2-2,5.69-2.46,8.19-1.37l.11,.05c.37,.16,.72,.38,1,.67,4.06,4.1,2.35,10.45,5.21,10.59s1.57-7.8,6.73-11.17h0c2.8-1.32,6.09-.62,8.13,1.9,1.28,1.58,.85,4.69,.85,6.98v6.23c0,1.3-.95,2.35-2.11,2.35Z'/%3E%3Cpath class='cls-1' d='M28.98,24.65l.73-.21h-.01c-1.2,.71-1.43,.72-1.6,2.39v6.96c0,.06-.13,.06-.29,.04h0c-.3-.03-.52-.13-.52-.24v-7.14c0-.38,.14-.75,.4-1.12h0c.2-.28,.67-.52,1.28-.7Z'/%3E%3Cpath class='cls-1' d='M44.43,20.33c-.1,.3-.63,1.37-1.05,3.24l-1.18,3.97c-.42,1.32-1.26,2.06-2.42,2.83h0c1.68-.14,3.08-1.31,3.49-2.91l.71-2.4c.32-2.05,0-3.7,.46-4.74Z'/%3E%3Cpath class='cls-1' d='M53.1,18.92l.26,.37c.86,1.24,1.35,1.86,1.35,3.61v10.43h0c0,.39-.37,.94-.8,1.11v-9.32c0-4.01-.12-4.71-.73-5.92l-.07-.28Z'/%3E%3C/g%3E%3C/svg%3E")`
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
          console.log("markers created")
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
