$(document).ready(function() {
  $('#thread-test').click(function() {
    $('#thread-test-row .col-lg-8').empty();

    var img = $('<img></img>')
      .attr('src', '/images/really-big-image.jpg')
      .appendTo('#thread-test-row .col-lg-8');

    $('#thread-test-row .col-lg-4 p').text('Image retrieval started, beginning file retrieval.');

    $([1,2,3,4,5,6,7,8,9,10]).each(function(){
      var number = this;
      $.getJSON("/test/" + number + ".json", function(data) {
        console.log(data);
        // var p = $('<p></p>').appendTo('#thread-test-row .col-lg-4');
        // p.text(data.value + "returned.");
      });
    });
  });
});
