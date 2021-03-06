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
    var photoUrl = lockup["url"];
    var marker = L.marker([lat, lon]).addTo(map);
    marker._leaflet_id = cid;
    var color = '';
    if( totalVotes > 0 ) {
      color = "green";
    }
    else if( totalVotes < 0 ) {
      color = "red";
    }
    if( photoUrl == '/images/thumb/missing.png') {
      photoUrl = "http://i.imgur.com/vBAW71x.png";
    }
    if(gon.user_signed_in) {
      marker.bindPopup( "<span>"+ name + "</span><br /><span>" + description + "</span><br /><div class='vote-container'><button class='upvote vote' data-up-id='"+cid+"'><img class='vote-img' src='http://i.imgur.com/AiBpAa7.png'></button><span id='"+cid+"' class='total-votes "+color+"'>"+totalVotes+"</span><button class='downvote vote' data-down-id='"+cid+"'><img class='vote-img' src='http://i.imgur.com/oQUIcmh.png'></button></div><br/><a href='/lock_ups/"+cid+"/edit'><img src='"+photoUrl+"'></a>" );
    } else {
      marker.bindPopup( "<span>"+ name + "</span><br /><span>" + description + "</span><br /><div class='vote-container'><span id='"+cid+"' class='total-votes "+color+"'>"+totalVotes+"</span></div><br /><img src='"+photoUrl+"'>" );      
    }
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
        var photoUrl = lockup["url"];
        marker.bindPopup( "<span>"+ name + "</span><br /><span>" + description + "</span><br /><div class='vote-container'><button class='upvote vote' data-up-id='"+id+"'><img class='vote-img' src='http://i.imgur.com/AiBpAa7.png></button><span id='"+id+"' class='total-votes'>"+response+"</span><button class='downvote vote' data-down-id='"+id+"'><img class='vote-img' src='http://i.imgur.com/oQUIcmh.png'></button></div><br /><a href='/lock_ups/"+id+"/edit'><img src='"+photoUrl+"'></a>" );
        var valId = $(".total-votes").attr("id");
        if ($("#"+valId).html() > 0 ) {
          $("#"+valId).removeClass("red");
          $("#"+valId).addClass("green");
        }
        else if ($("#"+valId).html() < 0 ){
          $("#"+valId).removeClass("green");
          $("#"+valId).addClass("red");
        }
      }
    })
  }
});
