$(document).ready(function() {

  var markerArray = new Array();
  $('#loading-js').hide();
  var map = L.map('map').setView([39.2833, -76.6167], 13);
  L.tileLayer("http://{s}.tiles.mapbox.com/v3/clickclickonsal.k80nf736/{z}/{x}/{y}.png", {
    attribution: 'Map data &copy; OpenStreetMap contributors, CC-BY-SA, Imagery © Mapbox',
    maxZoom: 18
  }).addTo(map);
// a.forEach(function(entry) {
//     console.log(entry);
// });
  var gonArray = new Array();
  var lockups = gon.lockups;
  lockups.forEach(function(lockup) {
    var lat = lockup["lat"];
    var lon = lockup["lon"];
    var cid = lockup["id"];
    var name = lockup["name"];
    var description = lockup["description"];
    var totalVotes = lockup["total_votes"];
    var marker = L.marker([lat, lon]).addTo(map);
    marker._leaflet_id = cid;
    marker.bindPopup( name + "<br />" + description + "<button class='upvote vote' data-up-id='"+cid+"'>UpVote</button><p class='total-votes'>"+totalVotes+"</p><button class='downvote vote' data-down-id='"+cid+"'>DownVote</button>" );
    markerArray[cid] = marker;
    gonArray[cid] = lockup;
  });

  $(document).on("click", "button", function() {
    if($(this).hasClass("upvote")){
      // debugger;
      var theID = $(this).attr('data-up-id');
      ajaxVote(theID, "up");
    }
    else if($(this).hasClass("downvote")){
      var theID = $(this).attr('data-down-id');
      ajaxVote(theID, "down");
    }
  });

  // map.on("popupclose", function(e) {
  //   var marker = e.popup._source;
  //   debugger;
  //   // marker.bindPopup( name + "<br />" + description + "<button class='upvote vote' data-up-id='"+cid+"'>UpVote</button><p class='total-votes'>"+totalVotes+"</p><button class='downvote vote' data-down-id='"+cid+"'>DownVote</button>" );
  //   var cid = marker._leaflet_id
  //   var description =
  //   var totalVotes =
  //   e.setContent( name + "<br />" + description + "<button class='upvote vote' data-up-id='"+cid+"'>UpVote</button><p class='total-votes'>"+totalVotes+"</p><button class='downvote vote' data-down-id='"+cid+"'>DownVote</button>" );
  // });

  function ajaxVote(id, direction) {
    $.ajax({
      url: "/lock_ups/vote",
      dataType: "json",
      method: "POST",
      data: { vote: { lock_up_id: id, direction: direction}},
      success: function(response) {
        // debugger;
        console.log(response);
        $(".total-votes").html(response);
        var marker = markerArray[id];
        var lockup = gonArray[id];
        var name = lockup["name"]
        var description = lockup["description"]
        marker.bindPopup( name + "<br />" + description + "<button class='upvote vote' data-up-id='"+id+"'>UpVote</button><p class='total-votes'>"+response+"</p><button class='downvote vote' data-down-id='"+id+"'>DownVote</button>" );
      }
    })
  }
});
