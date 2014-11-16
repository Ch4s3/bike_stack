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
    marker.bindPopup( "<span>"+ name + "</span><br /><span>" + description + "</span><br /><div class='vote-container'><button class='upvote vote' data-up-id='"+cid+"'><img class='vote-img' src='http://i.imgur.com/AiBpAa7.png'></button><span class='total-votes'>"+totalVotes+"</span><button class='downvote vote' data-down-id='"+cid+"'><img class='vote-img' src='http://i.imgur.com/oQUIcmh.png'></button></div>" );
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

  function ajaxVote(id, direction) {
    $.ajax({
      url: "/lock_ups/vote",
      dataType: "json",
      method: "POST",
      data: { vote: { lock_up_id: id, direction: direction}},
      success: function(response) {
        // debugger;
        $(".total-votes").html(response);
        var marker = markerArray[id];
        var lockup = gonArray[id];
        var name = lockup["name"];
        var description = lockup["description"];
        marker.bindPopup( "<span>"+ name + "</span><br /><span>" + description + "</span><br /><div class='vote-container'><button class='upvote vote' data-up-id='"+id+"'><img class='vote-img' src='http://i.imgur.com/AiBpAa7.png></button><span class='total-votes'>"+response+"</span><button class='downvote vote' data-down-id='"+id+"'><img class='vote-img' src='http://i.imgur.com/oQUIcmh.png'></button></div>" );
      }
    })
  }
});
